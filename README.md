
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mermaidr

<!-- badges: start -->

<!-- badges: end -->

The goal of `mermaidr` is to access [MERMAID
Collect](https://collect.datamermaid.org/) data directly from R.

## Installation

You can install mermaidr from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("data-mermaid/mermaidr@package", upgrade = "never")
```

Next, load the package:

``` r
library(mermaidr)
```

## Authentication

`mermaidr` will help you interact with MERMAID Collect as an
authenticated user, as soon as you need. This is only required for
accessing project specific data. To access a list of projects, sites,
etc, you do not need to be authenticated.

If you would like to authenticate yourself immediately, use
`mermaid_auth()`. This will open your browser to the MERMAID Collect
login. Once you log in, you can go back to R and will be authenticated.

The login credentials expire every 24 hours. Once your credentials are
expired, `mermaidr` will again help you automatically authenticate when
needed.

## Usage

All functions in `mermaidr` are of the form `mermaid_*()`, to make
functions easier to find and use when loaded with other packages\!

To access the unauthenticated API endpoints, use
`mermaid_get_endpoint()`. The results will return as a `tibble.` The
following endpoints are available: “benthicattributes”,
“fishattributes”, “fishfamilies”, “fishgenera”, “fishspecies”,
“managements”, “projects”, “sites”.

For example,

``` r
library(mermaidr)

mermaid_get_endpoint("sites")
#> # A tibble: 1,404 x 13
#>    id    name  notes project latitude longitude country reef_type reef_zone
#>    <chr> <chr> <chr> <chr>      <dbl>     <dbl> <chr>   <chr>     <chr>    
#>  1 6e7f… 1201  "Pul… c08ff9…    -2.02      134. Indone… fringing  fore reef
#>  2 c7e2… 1201  "Pul… 988e75…    -2.02      134. Indone… fringing  fore reef
#>  3 baaa… 1201  "Pul… 841534…    -2.02      134. Indone… fringing  fore reef
#>  4 0a26… 1201  "Pul… 841534…    -2.02      134. Indone… fringing  fore reef
#>  5 95ad… 1201  "Pul… 3d6edb…    -2.02      134. Indone… fringing  fore reef
#>  6 e981… 1201  "Pul… c29a9e…    -2.02      134. Indone… fringing  fore reef
#>  7 9fe1… 1201  "Pul… 07df6a…    -2.02      134. Indone… fringing  fore reef
#>  8 a467… 1202  "Nap… 07df6a…    -2.91      135. Indone… fringing  fore reef
#>  9 d74d… 1202  "Nap… 3d6edb…    -2.91      135. Indone… fringing  fore reef
#> 10 46ac… 1203  "Pul… 07df6a…    -3.06      135. Indone… fringing  back reef
#> # … with 1,394 more rows, and 4 more variables: exposure <chr>,
#> #   predecessor <chr>, created_on <chr>, updated_on <chr>
```

By default, the function returns all results - to get less, use the
`limit` argument:

``` r
mermaid_get_endpoint("managements", limit = 5)
#> # A tibble: 5 x 17
#>   id    name  name_secondary rules notes est_year no_take periodic_closure
#>   <chr> <chr> <chr>          <chr> <chr>    <int> <lgl>   <lgl>           
#> 1 23c6… Amba… ""             No T… ""        2013 TRUE    FALSE           
#> 2 d007… Amba… ""             No T… ""        2013 TRUE    FALSE           
#> 3 704e… Amba… ""             No T… ""        2013 TRUE    FALSE           
#> 4 bbe7… Amba… ""             No T… ""        2013 TRUE    FALSE           
#> 5 2374… Amba… ""             No T… ""        2013 TRUE    FALSE           
#> # … with 9 more variables: open_access <lgl>, size_limits <lgl>,
#> #   gear_restriction <lgl>, species_restriction <lgl>, compliance <chr>,
#> #   predecessor <chr>, parties <chr>, created_on <chr>, updated_on <chr>
```

For specifically listing projects, there is a wrapper function
`mermaid_list_projects()`:

``` r
mermaid_list_projects(limit = 5)
#> # A tibble: 5 x 14
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 fe3f… 1000… ""                0 ""    "The… Open   Public Summary  
#> 2 60dd… 2013… "Fiji"           17 "WCS… ""    Open   Private         
#> 3 7376… 2014… "Fiji"           24 "WCS… "Thi… Open   Private         
#> 4 ac93… 2016… "Fiji"           24 "WCS… "Thi… Open   Private         
#> 5 e1ef… 2016… "Fiji"            8 "WCS… "Nam… Open   Private         
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

This will list all (as many as `limit`) projects. By default, it does
*not* include test projects. To include test projects, set
`include_test_projects = TRUE`.

To specifically access projects that you *have access to*, use
`mermaid_list_my_projects()`:

``` r
mermaid_list_my_projects(limit = 1)
#> # A tibble: 1 x 14
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 d549… 2017… Fiji             31 WCS … This… Open   Private         
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

This will return a list of projects that you have access to in Collect.
Again, this does not include test projects.

#### Multiple endpoints

To get data from multiple endpoints, pass a vector of endpoints. You
will get a list of tibbles:

``` r
mermaid_get_endpoint(c("managements", "sites"), limit = 1)
#> $managements
#> # A tibble: 1 x 17
#>   id    name  name_secondary rules notes est_year no_take periodic_closure
#>   <chr> <chr> <chr>          <chr> <chr>    <int> <lgl>   <lgl>           
#> 1 bbe7… Amba… ""             No T… ""        2013 TRUE    FALSE           
#> # … with 9 more variables: open_access <lgl>, size_limits <lgl>,
#> #   gear_restriction <lgl>, species_restriction <lgl>, compliance <chr>,
#> #   predecessor <chr>, parties <chr>, created_on <chr>, updated_on <chr>
#> 
#> $sites
#> # A tibble: 1 x 13
#>   id    name  notes project latitude longitude country reef_type reef_zone
#>   <chr> <chr> <chr> <chr>      <dbl>     <dbl> <chr>   <chr>     <chr>    
#> 1 9fe1… 1201  Pula… 07df6a…    -2.02      134. Indone… fringing  fore reef
#> # … with 4 more variables: exposure <chr>, predecessor <lgl>, created_on <chr>,
#> #   updated_on <chr>
```

### Accessing project data

You will be able to access data from a specific project, provided that
you have access to it in the Collect app. To access data for a project,
you can either use a project from `mermaid_list_my_projects()` (as
above), a `project_id` directly, or a project from
`mermaid_search_projects()`.

For
example:

``` r
mermaidr_project <- mermaid_search_projects(name = "Sharla test", include_test_projects = TRUE)

mermaidr_project
#> # A tibble: 1 x 14
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 2c0c… Shar… Indonesia         1 ""    "dhf… Test   Public Summary  
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

returns a single project with the name “Sharla test”.

You can also search projects by country or tag:

``` r
mermaid_search_projects(country = "Fiji")
#> # A tibble: 23 x 14
#>    id    name  countries num_sites tags  notes status data_policy_bel…
#>    <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#>  1 60dd… 2013… Fiji             17 WCS … ""    Open   Private         
#>  2 7376… 2014… Fiji             24 WCS … "Thi… Open   Private         
#>  3 ac93… 2016… Fiji             24 WCS … "Thi… Open   Private         
#>  4 e1ef… 2016… Fiji              8 WCS … "Nam… Open   Private         
#>  5 d549… 2017… Fiji             31 WCS … "Thi… Open   Private         
#>  6 c0ba… 2018… Fiji             22 WCS … "Thi… Open   Private         
#>  7 170e… 2018… Fiji             10 WCS … "Thi… Open   Private         
#>  8 95e0… 2019… Fiji             44 WCS … ""    Open   Private         
#>  9 d065… 2019… Fiji             31 WCS … "Ble… Open   Private         
#> 10 6c6c… 2019… Fiji             18 WCS … "Mac… Open   Private         
#> # … with 13 more rows, and 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

and if you only want to search *your* projects, pass your token to the
function:

``` r
mermaid_search_projects(country = "Fiji", token = mermaid_token())
#> # A tibble: 1 x 14
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 d549… 2017… Fiji             31 WCS … This… Open   Private         
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

Note that the country and tag searches search if the countries/tag
fields *contain* that value, since they may not always be exactly what
you expect. For example, to search projects in Tanzania:

``` r
mermaid_search_projects(country = "Tanzania", limit = 1)[["countries"]]
#> [1] "Tanzania, United Republic of"
```

If you need help figuring out what a country is named, use
`mermaid_countries()`, which will list how countries are named in
MERMAID:

``` r
head(
  mermaid_countries()
)
#> [1] "Afghanistan"    "Åland Islands"  "Albania"        "Algeria"       
#> [5] "American Samoa" "Andorra"
```

You can use this to access an endpoint for the project, using
`get_mermaid_project_endpoint()`. The following project endpoints are
available: “beltfishtransectmethods”, “beltfishes”,
“benthiclittransectmethods”, “benthicpittransectmethods”,
“benthicpits”, “collectrecords”, “habitatcomplexities”,
“obsbenthiclits”, “obsbenthicpits”, “obshabitatcomplexities”,
“obstransectbeltfishs”, “managements”, “observers”,
“project\_profiles”, “sampleevents”, “sites”.

At this point, you will have to authenticate to the Collect app. R will
help you do this automatically by opening a browser window for you to
log in to Collect, either via Google sign-in or username and password -
however you normally do\!

Once you’ve logged in, come back to R. Your login credentials will be
stored for a day, until they expire, and you will need to login again.
The package handles the expiration for you, so just log in again when
prompted.

#### Raw endpoints

The following endpoints contain raw data: “beltfishtransectmethods”,
“beltfishes”, “benthiclittransectmethods”,
“benthicpittransectmethods”, “benthicpits”, “collectrecords”,
“habitatcomplexities”, “obsbenthiclits”, “obsbenthicpits”,
“obshabitatcomplexities”, “obstransectbeltfishs”, “managements”,
“observers”, “project\_profiles”, “sampleevents”, “sites”,
“beltfishes/obstransectbeltfishes”, “beltfishes/sampleunits”, and
“beltfishes/sampleevents”.

Cleaner endpoints are covered in the next section. These are:
“beltfishes/obstransectbeltfishes”, “beltfishes/sampleunits”, and
“beltfishes/sampleevents”.

For example, to see the sites in this project:

``` r
mermaid_get_project_endpoint(mermaidr_project, "sites")
#> # A tibble: 1 x 12
#>   id    name  notes latitude longitude country reef_type reef_zone exposure
#>   <chr> <chr> <chr>    <dbl>     <dbl> <chr>   <chr>     <chr>     <chr>   
#> 1 7465… 1201  Pula…    -2.02      134. Indone… fringing  fore reef exposed 
#> # … with 3 more variables: predecessor <chr>, created_on <chr>,
#> #   updated_on <chr>
```

You can also use the `project_id` directly to access data from a
project, without having to search for it first. This may be handy since
the `project_id` is directly available from the URL when using the
collect
app.

``` r
mermaid_get_project_endpoint("2c0c9857-b11c-4b82-b7ef-e9b383d1233c", "managements")
#> # A tibble: 2 x 16
#>   id    name  name_secondary notes est_year no_take periodic_closure open_access
#>   <chr> <chr> <chr>          <chr>    <int> <lgl>   <lgl>            <lgl>      
#> 1 cffd… Fake… ""             ""        2018 FALSE   TRUE             FALSE      
#> 2 ea09… Fish… ""             ""        2019 FALSE   FALSE            FALSE      
#> # … with 8 more variables: size_limits <lgl>, gear_restriction <lgl>,
#> #   species_restriction <lgl>, compliance <chr>, predecessor <chr>,
#> #   parties <chr>, created_on <chr>, updated_on <chr>
```

If you want to access data from the same project multiple times within a
session, it may be useful to set the default project, rather than having
to supply it every time. You can do this using
`mermaid_set_default_project()`. Then, you can just supply the endpoint,
and the default project is used.

``` r
mermaid_set_default_project(mermaidr_project)
mermaid_get_project_endpoint(endpoint = "beltfishes")
#> # A tibble: 1 x 4
#>   id                  transect              created_on         updated_on       
#>   <chr>               <chr>                 <chr>              <chr>            
#> 1 5b16efbc-0910-4576… 0b325bfe-eefc-4c6c-a… 2020-03-09T14:36:… 2020-03-09T14:36…
```

To get data for *all* endpoints associated with a project, use
`mermaid_get_all_project_endpoints()`. This will return a list of
tibbles, one for each endpoint.

``` r
all_endpoints <- mermaid_get_all_project_endpoints()

names(all_endpoints)
#>  [1] "beltfishtransectmethods"          "beltfishes"                      
#>  [3] "benthiclittransectmethods"        "benthicpittransectmethods"       
#>  [5] "benthicpits"                      "collectrecords"                  
#>  [7] "fishbelttransects"                "habitatcomplexities"             
#>  [9] "obsbenthiclits"                   "obsbenthicpits"                  
#> [11] "obshabitatcomplexities"           "obstransectbeltfishs"            
#> [13] "managements"                      "observers"                       
#> [15] "project_profiles"                 "sampleevents"                    
#> [17] "sites"                            "beltfishes/obstransectbeltfishes"
#> [19] "beltfishes/sampleunits"           "beltfishes/sampleevents"

all_endpoints[["sites"]]
#> # A tibble: 1 x 12
#>   id    name  notes latitude longitude country reef_type reef_zone exposure
#>   <chr> <chr> <chr>    <dbl>     <dbl> <chr>   <chr>     <chr>     <chr>   
#> 1 7465… 1201  Pula…    -2.02      134. Indone… fringing  fore reef exposed 
#> # … with 3 more variables: predecessor <chr>, created_on <chr>,
#> #   updated_on <chr>
```

#### Multiple projects

You can get endpoint data for multiple projects. The results will be in
a single tibble:

``` r
library(dplyr)

mermaid_list_my_projects(include_test_projects = TRUE) %>%
  filter(status == "Test") %>%
  mermaid_get_project_endpoint("sites", limit = 1)
#> # A tibble: 2 x 13
#>   project id    name  notes latitude longitude country reef_type reef_zone
#>   <chr>   <chr> <chr> <chr>    <dbl>     <dbl> <chr>   <chr>     <chr>    
#> 1 Sharla… 7465… 1201  Pula…    -2.02      134. Indone… fringing  fore reef
#> 2 sharla… fcb0… 1201  Pula…    -2.02      134. Indone… fringing  fore reef
#> # … with 4 more variables: exposure <chr>, predecessor <chr>, created_on <chr>,
#> #   updated_on <chr>
```

If you want multiple endpoints for multiple projects, the results will
be a list of tibbles:

``` r
mermaid_list_my_projects(include_test_projects = TRUE) %>%
  filter(status == "Test") %>%
  mermaid_get_project_endpoint(c("managements", "sites"), limit = 1)
#> $managements
#> # A tibble: 1 x 16
#>   id    name  name_secondary notes est_year no_take periodic_closure open_access
#>   <chr> <chr> <chr>          <chr>    <int> <lgl>   <lgl>            <lgl>      
#> 1 cffd… Fake… ""             ""        2018 FALSE   TRUE             FALSE      
#> # … with 8 more variables: size_limits <lgl>, gear_restriction <lgl>,
#> #   species_restriction <lgl>, compliance <chr>, predecessor <chr>,
#> #   parties <chr>, created_on <chr>, updated_on <chr>
#> 
#> $sites
#> # A tibble: 2 x 13
#>   project id    name  notes latitude longitude country reef_type reef_zone
#>   <chr>   <chr> <chr> <chr>    <dbl>     <dbl> <chr>   <chr>     <chr>    
#> 1 Sharla… 7465… 1201  Pula…    -2.02      134. Indone… fringing  fore reef
#> 2 sharla… fcb0… 1201  Pula…    -2.02      134. Indone… fringing  fore reef
#> # … with 4 more variables: exposure <chr>, predecessor <chr>, created_on <chr>,
#> #   updated_on <chr>
```

#### Clean Endpoints

The “clean” endpoints currently available are for beltfish records:
“beltfishes/obstransectbeltfishes”, “beltfishes/sampleunits”, and
“beltfishes/sampleevents”.

You can query them the same way, using `mermaid_get_project_endpoint()`:

“beltfishes/obstransectbeltfishes” are individual observations:

``` r
xpdc <- mermaid_search_projects("XPDC Kei Kecil 2018")

mermaid_get_project_endpoint(xpdc, "beltfishes/obstransectbeltfishes", limit = 5)
#> # A tibble: 5 x 45
#>   project tags  country site  latitude longitude reef_type reef_zone
#>   <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#> 1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 2 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 3 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 4 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 5 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> # … with 37 more variables: reef_exposure <chr>, reef_slope <lgl>, tide <chr>,
#> #   current <chr>, visibility <chr>, management <chr>,
#> #   management_secondary <chr>, management_est_year <lgl>,
#> #   management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <chr>,
#> #   sample_time <chr>, transect_length <int>, transect_width <chr>,
#> #   size_bin <int>, observers <chr>, depth <dbl>, transect_number <int>,
#> #   label <chr>, fish_family <chr>, fish_genus <chr>, fish_taxon <chr>,
#> #   size <dbl>, biomass_constant_a <dbl>, biomass_constant_b <dbl>,
#> #   biomass_constant_c <dbl>, biomass_kgha <dbl>, trophic_level <dbl>,
#> #   functional_group <chr>, vulnerability <dbl>, data_policy_beltfish <chr>,
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>,
#> #   contact_link <chr>
```

“beltfishes/sampleunits” are aggregated to the sample unit, and contain
total biomass in kg/ha per sample unit, by trophic group:

``` r
mermaid_get_project_endpoint(xpdc, "beltfishes/sampleunits", limit = 5)
#> # A tibble: 5 x 34
#>   project tags  country site  latitude longitude reef_type reef_zone
#>   <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#> 1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 2 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 3 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 4 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 5 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> # … with 30 more variables: reef_exposure <chr>, reef_slope <lgl>, tide <chr>,
#> #   current <chr>, visibility <chr>, management <chr>,
#> #   management_secondary <chr>, management_est_year <lgl>,
#> #   management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <chr>,
#> #   depth <dbl>, transect_number <int>, size_bin <int>, transect_length <int>,
#> #   transect_width <chr>, biomass_kgha <dbl>,
#> #   biomass_kgha_by_trophic_group$omnivore <dbl>, $piscivore <dbl>,
#> #   $planktivore <dbl>, $`invertivore-mobile` <dbl>,
#> #   $`herbivore-detritivore` <dbl>, data_policy_beltfish <chr>,
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>, id <chr>,
#> #   contact_link <chr>
```

“beltfishes/sampleevents” are aggregated to the sample event, and
contain *mean* total biomass in kg/ha per sample event and by trophic
group:

``` r
mermaid_get_project_endpoint(xpdc, "beltfishes/sampleevents", limit = 5)
#> # A tibble: 5 x 26
#>   project tags  country site  latitude longitude reef_type reef_zone
#>   <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#> 1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 2 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#> 3 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#> 4 XPDC K… NA    Indone… KE05     -5.47      133. fringing  crest    
#> 5 XPDC K… NA    Indone… KE06     -5.52      132. fringing  crest    
#> # … with 24 more variables: reef_exposure <chr>, management <chr>,
#> #   management_secondary <chr>, management_est_year <lgl>,
#> #   management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <chr>,
#> #   depth_avg <dbl>, biomass_kgha_avg <dbl>,
#> #   biomass_kgha_by_trophic_group_avg$omnivore <dbl>, $piscivore <dbl>,
#> #   $planktivore <dbl>, $`invertivore-mobile` <dbl>,
#> #   $`herbivore-detritivore` <dbl>, $`invertivore-sessile` <dbl>,
#> #   $`herbivore-macroalgae` <dbl>, data_policy_beltfish <chr>,
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>,
#> #   sample_unit_count <int>, contact_link <chr>
```
