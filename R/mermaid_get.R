#' @param endpoint Endpoint
#' @param limit Number of records to get. Use NULL (the default) to get all records.
#' @param token API token. Not required for unauthenticated endpoints. Get manually via \code{\link{mermaid_auth}} or automatically when running a function that requires a token.
#' @param ... Additional parameters used as needed
#'
#' @name mermaid_GET
NULL

#' Get MERMAID endpoint
#'
#' @inheritParams mermaid_GET
#' @noRd
mermaid_GET <- function(endpoint, limit = NULL, token = NULL, ...) {
  check_internet()
  limit <- check_limit(limit)

  # Convert endpoint(s) into list
  endpoints <- vector("list", length = length(endpoint))
  names(endpoints) <- endpoint

  # Construct API path
  path <- purrr::map(names(endpoints), construct_api_path, token = token, limit = limit, ...)
  names(path) <- endpoint

  # Call API and return results
  res <- purrr::map2(path, basename(names(path)), get_response, ua = ua, token = token, limit = limit)

  # Remove validation column, collapse list-cols
  purrr::map2(res, names(res), initial_cleanup)
}

check_errors <- function(response) {
  if (httr::http_error(response)) {
    stop(paste0(
      "Mermaid API request failed: (", httr::status_code(response), ") ",
      httr::http_status(response)[["reason"]]
    ),
    call. = FALSE
    )
  }
}

construct_api_path <- function(endpoint, token, limit, ...) {
  # Construct first page - maximum size is 5000
  limit <- ifelse(is.null(limit) || limit > 5000, 5000, limit)

  if (endpoint == "projects" & is.null(token)) {
    # Need showall = TRUE if it's the "projects" endpoint and not an authenticated call
    path <- httr::modify_url(base_url, path = paste0("v1/", endpoint, "/"), query = list(limit = limit, showall = TRUE, ...))
  } else {
    path <- httr::modify_url(base_url, path = paste0("v1/", endpoint, "/"), query = list(limit = limit, ...))
  }
}

get_response <- function(path, endpoint, ua, token, limit) {
  if (endpoint == "choices") {
    get_choices_response(path, endpoint, ua, token, limit)
  } else if (stringr::str_detect(path, "ingest_schema_csv")) {
    get_csv_response(path, ua, token)
  } else if (stringr::str_detect(path, "ingest_schema")) {
    get_ingest_schema_response(path, ua, token)
  } else {
    get_paginated_response(path, ua, token, limit)
  }
}

get_choices_response <- function(path, endpoint, ua, token, limit) {
  parsed <- get_and_parse(path = path, ua = ua, token = token)
  res <- tibble::as_tibble(parsed)
  res[["data"]] <- sapply(res[["data"]], tibble::as_tibble)

  if (is.null(limit)) {
    res
  } else {
    head(res, limit)
  }
}

get_csv_response <- function(path, ua, token) {
  get_and_parse(path, ua, token)
}

get_paginated_response <- function(path, ua, token, limit) {
  all_res <- list()
  i <- 1
  res <- get_and_parse(path = path, ua = ua, token = token)

  all_res[[i]] <- res[["results"]]
  n_res <- nrow(all_res[[i]])

  while (!is.null(res$`next`) && (is.null(limit) || n_res < limit)) {
    path <- res$`next`
    i <- i + 1
    res <- get_and_parse(path = path, ua = ua, token = token)
    all_res[[i]] <- res[["results"]]
    n_res <- n_res + nrow(all_res[[i]])
  }

  res <- dplyr::bind_rows(all_res)
  res <- tibble::as_tibble(res)

  if (is.null(limit)) {
    res
  } else {
    head(res, limit)
  }
}

get_ingest_schema_response <- function(path, ua, token) {
  get_and_parse(path, ua, token, simplify_df = FALSE)
}

get_and_parse <- function(path, ua, token, simplify_df = TRUE) {
  resp <- suppress_http_warning(httr::RETRY("GET", path, ua, token, terminate_on = c(401, 403)))
  check_errors(resp)

  # Check if content type is available in header, otherwise use path for deciding what to parse
  content_type <- httr::headers(resp)[["content-type"]]

  if (is.null(content_type)) {
    parse_csv <- stringr::str_detect(path, "csv")
  } else {
    parse_csv <- content_type == "text/csv"
  }

  # Parse CSV and JSON differently
  if (parse_csv) {
    httr::content(resp, "raw", encoding = "UTF-8") %>%
      readr::read_csv(show_col_types = FALSE, progress = FALSE)
  } else {
    jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyDataFrame = simplify_df)
  }
}

suppress_http_warning <- function(expr, warning_function = "parse_http_status", warning_regex = "NAs introduced by coercion") {
  withCallingHandlers(expr, warning = function(w) {
    if (length(warning_function) == 1 && length(grep(warning_function, conditionCall(w))) && length(grep(warning_regex, conditionMessage(w)))) {
      invokeRestart("muffleWarning")
    }
  })
}

initial_cleanup <- function(results, endpoint) {
  path <- endpoint
  endpoint <- basename(path)

  if (stringr::str_detect(path, "ingest_schema")) {
    return(results)
  }

  if ((nrow(results) == 0 || ncol(results) == 0) & !stringr::str_detect(path, "ingest_schema_csv")) {
    return(
      tibble::tibble()
    )
  }

  if ("validations" %in% names(results)) {
    results <- results %>%
      dplyr::select(-.data$validations)
  }

  if (endpoint == "sites") {
    results <- results %>%
      tidyr::unpack(cols = c(.data$location)) %>%
      tidyr::hoist(.data$coordinates,
        latitude = 2,
        longitude = 1
      ) %>%
      dplyr::select(-.data$type)
  }

  if ("covariates" %in% names(results)) {
    results <- results %>%
      extract_covariates()
  }

  if (endpoint != "choices") {
    results <- collapse_id_name_lists(results)

    results <- results %>%
      dplyr::rowwise() %>%
      dplyr::mutate_if(is_list_col, ~ paste0(.x, collapse = "; ")) %>%
      dplyr::ungroup()
  }

  if (all(c("profile", "profile_name") %in% names(results))) {
    results <- dplyr::select(results, -.data$profile) %>%
      dplyr::rename(profile = .data$profile_name)
  }

  if (all(c("project", "project_name") %in% names(results))) {
    results <- dplyr::select(results, -.data$project) %>%
      dplyr::rename(project = .data$project_name)
  }

  if ("transect_len_surveyed" %in% names(results)) {
    results <- dplyr::rename(results, transect_length = .data$transect_len_surveyed)
  }

  if ("sample_date" %in% names(results)) {
    results <- dplyr::mutate(results, sample_date = as.Date(.data$sample_date))
  }

  results
}

is_list_col <- function(x) {
  is.list(x) && !is.data.frame(x)
}

collapse_id_name_lists <- function(results) {
  list_col_lgl <- purrr::map_lgl(results, inherits, "list")
  list_cols <- names(list_col_lgl[list_col_lgl])

  for (i in seq_along(list_cols)) {
    if (all(c("id", "name") %in% names(results[[list_cols[[i]]]][[1]]))) {
      results <- results %>%
        tidyr::hoist(list_cols[[i]], list_name = "name") %>%
        dplyr::select(-list_cols[[i]]) %>%
        dplyr::rename(!!list_cols[[i]] := .data$list_name)
    }
  }

  results
}

extract_covariates <- function(results) {
  covariates_expanded <- results[["covariates"]] %>%
    purrr::compact() %>%
    purrr::map(function(x) {
      x %>%
        dplyr::mutate(value = purrr::map(
          .data$value,
          function(y) {
            if (is.null(y)) NA else y
          }
        ))
    }) %>%
    dplyr::bind_rows(.id = "row") %>%
    dplyr::select(.data$row, .data$name, .data$value) %>%
    split(.$name) %>%
    purrr::map(~ .x %>% dplyr::mutate(value = purrr::map_chr(.data$value, get_covariate_value))) %>%
    dplyr::bind_rows() %>%
    tidyr::pivot_wider(id_cols = row, names_from = .data$name, values_from = .data$value) %>%
    dplyr::mutate(dplyr::across(-dplyr::starts_with("aca_"), as.numeric))

  results %>%
    dplyr::mutate(row = dplyr::row_number()) %>%
    dplyr::left_join(covariates_expanded, by = "row") %>%
    dplyr::select(-.data$row, -.data$covariates)
}

get_covariate_value <- function(x) {
  if (length(x) == 0) { # If there is no value, return NA
    return(NA)
  } else if (length(x) == 1) { # If it's a single value, just return the value
    return(x)
  }

  # Otherwise, get the value for the max area
  x %>%
    dplyr::filter(.data$area == max(.data$area)) %>%
    dplyr::pull(.data$name)
}
