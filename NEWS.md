# mermaidr 0.6.4

* Add ingestion docs

# mermaidr 0.6.3

* Allow export of "benthicpqt" data via `mermaid_get_project_data()`

# mermaidr 0.6.2

* Allow import of "benthicpqt" data via `mermaid_import_project_data()`
* Enable `mermaid_import_project_data()` to take `project`, not `project_id`, consistent with other functions

# mermaidr 0.6.1

* Remove fuzzyjoin/stringdist dependency, calculate differences for strings in `mermaid_import_check_options()` more manually.

# mermaidr 0.6.0

* Remove `mermaid_get_summary_sites()` as endpoint has been removed.
* Ensure all `NA`s are written to `''` to appear as blanks, not literal `"NA"` in mermaid_import_project_data().

# mermaidr 0.5.1

* Fix bug with retrieving content type from headers.

# mermaidr 0.5.0

* Add `mermaid_get_summary_sampleevents()` for getting aggregated metrics for all MERMAID surveys, by site, by date, and `mermaid_get_summary_sites()` for getting aggregated metrics for all MERMAID surveys, by site, for *all* dates.
* Add `mermaid_import_get_template_and_options()` to get a template and field options for importing any method into MERMAID.
* Add `mermaid_import_check_options()` for verifying that data being prepared for import matches the field options allowed.
* Remove `mermaid_import_field_options()`, replaced by the above two functions (which are more feature rich and complete).

# mermaidr 0.4.6

* Handle presence of all covariates, convert `NULL` covariates to `NA`.

# mermaidr 0.4.5

* Fix bug where `mermaid_get_project_data()` functions failed if `andrello` or `beyer` covariates were not present, and data for multiple projects is being selected (0.4.4 only fixed the single-project case).

# mermaidr 0.4.4.

* Fix bug where `mermaid_get_project_data()` functions failed if `andrello` or `beyer` covariates were not present.

# mermaidr 0.4.3

* Added all Vibrant Oceans covariates to aggregated endpoints (in `mermaid_get_project_data()`).
* Handle _any_ missing (`NA`) values in `mermaid_import_project_data()` by automatically converting to an empty value, which is processed by the API as a NULL, before importing.

# mermaidr 0.4.2

* Handle missing `Sample time` values in `mermaid_import_project_data()` by automatically converting `NA` to `""` before importing.

# mermaidr 0.4.1

* `mermaid_get_sites()` and `mermaid_get_managements()` now require authorization.
* Added vignette on accessing development data.

# mermaidr 0.4.0

* Added ability to import data into MERMAID via `mermaid_import_project_data()`.
* Added `mermaid_import_field_options()` to check valid options for fields in import.

# mermaidr 0.3.2

* Removed ability to query "beltfishes", "benthicpits", and "habitatcomplexities" in `mermaid_get_project_endpoint()`, since the endpoints were removed from the underlying API.
* Bug fixes.

# mermaidr 0.3.1

* Updated `mermaid_get_reference()` to include regions.

# mermaidr 0.3.0

* Updated `mermaid_get_project_data()` to automatically unpack any data frame columns. This affects the fishbelt, benthic PIT, and benthic LIT methods, for both sample units and sample events data. This is a breaking change, expected to affect existing code that uses the `biomass_kgha_by_trophic_group`, `biomass_kgha_by_fish_family`, and `percent_cover_by_benthic_category` columns in sample units, and their `*_avg` counterparts in sample events. Instead of these columns, results will now contain a column for subgroup - for example, instead of `biomass_kgha_by_trophic_group` there will be columns such as `biomass_kgha_trophic_group_piscivore` and `biomass_kgha_trophic_group_planktivore`.
* Updated `mermaid_get_reference()` to provide enhanced reference data, returning actual values for e.g. fish family, sizes, groups, etc, instead of their internal IDs. The `display` column for the "fishspecies" reference has been renamed to `species` ([#21](https://github.com/data-mermaid/mermaidr/issues/21)).

# mermaidr 0.2.4

* Fixed bug introduced by handling `NULL` `covariates`.

# mermaidr 0.2.3

* Fixed bug with handling of covariates (now properly handles case where `covariates` are `NULL`).

# mermaidr 0.2.2

* Added Allen Coral Atlas covariates to all aggregated endpoints (in `mermaid_get_project_data()`).
* Added `biomass_kgha_by_fish_family` and `biomass_kgha_by_fish_family_avg` to fishbelt sample units and sample events, respectively (in `mermaid_get_project_data()`).

# mermaidr 0.2.1

* Terminating `httr::RETRY()` after one failure if the status code indicates an unauthorized request; no need to retry in those cases.

# mermaidr 0.2.0

* Big addition of Benthic LIT, Bleaching, and Habitat Complexity methods in `mermaid_get_project_data()`, and additional fields available in Fish Belt and Benthic PIT endpoints.
* Removed `url` argument from most external functions, since switching between prod and dev is more complicated than just changing the `url` - especially for authenticated endpoint calls. For now, switching between prod and dev requires installing from the main and dev branches, respectively. I will continue to explore making the token generation more robust for accessing both prod and dev, at which point the `url` argument will likely return!
* Using `httr::RETRY()` instead of `httr::GET()` to make functions more resilient to e.g. temporary API outages or timeouts
* Documentation improvements.

# mermaidr 0.1.1

* Fix bug related to stricter row binding behaviour from updated version of `vctrs`.
* Use trailing slash on endpoints to avoid redirects.
* Suppress warning caused by introduction of `HTTP_API_VERSION` header that is not properly handled by the `httr` package (https://github.com/r-lib/httr/issues/590).
* Add missing `count` column to fishbelt observations (queried via `mermaid_get_project_data(method = "fishbelt", data = "observations")`).

# mermaidr 0.1.0

* Initial release.
