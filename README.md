
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mermaidr

<!-- badges: start -->

[![CircleCI build
status](https://circleci.com/gh/data-mermaid/mermaidr.svg?style=svg)](https://circleci.com/gh/data-mermaid/mermaidr)
<!-- badges: end -->

The goal of `mermaidr` is to access [MERMAID
Collect](https://collect.datamermaid.org/) data directly from R. It
works alongside the [`mermaidreporting`
package](https://github.com/data-mermaid/mermaidreporting), which helps
to clean, summarize, and visualize MERMAID data.

If you run into any problems working with this package, please open an
[issue](https://github.com/data-mermaid/mermaidr/issues).

## Installation

You can install mermaidr from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("data-mermaid/mermaidr", upgrade = "never")
```

Next, load the package:

``` r
library(mermaidr)
```

If you would like to access the development version of MERMAID instead,
you can install the `dev` branch of this package:

``` r
# install.packages("remotes")
remotes::install_github("data-mermaid/mermaidr", ref = "dev", upgrade = "never")
```

When using the development version, you can only access data from the 
[development version of MERMAID
Collect](https://dev-collect.datamermaid.org/). There may also be 
differences in the MERMAID API (which can affect things like the 
columns returned) and functions in `mermaidr` that are 
in-progress and not yet available from the “production” version 
of the package.

When using the development version, you can only access data from the
[development version of MERMAID
Collect](https://dev-collect.datamermaid.org/). There will also be
functions in `mermaidr` that are in-progress and not yet available from
the “production” version of the package.

## Authentication

`mermaidr` will help you interact with MERMAID Collect as an
authenticated user, as soon as you need. This is only required for
accessing project specific data. To access a list of all projects,
sites, etc, you do not need to be authenticated.

If you would like to authenticate yourself immediately, use
`mermaid_auth()`. This will open your browser to the MERMAID Collect
login. Once you log in, you can go back to R and will be authenticated.

The login credentials expire every 24 hours. Once your credentials are
expired, `mermaidr` will again help you automatically authenticate when
needed.

Note that authentication is only possible locally on your desktop, using
a program like RStudio. This should cover most people and cases, however
it’s not currently possible to authenticate on something like RStudio
Cloud or on another server. If you are using a server, please follow the
directions
[here](https://support.rstudio.com/hc/en-us/articles/217952868-Generating-OAuth-tokens-from-a-server)
to authenticate on the desktop then copy to the server.

## Usage

All functions in `mermaidr` are of the form `mermaid_*()`, to make
functions easier to find and use when loaded with other packages\!

## Accessing project data

To access data related to your MERMAID projects, first obtain a list of
your projects with `mermaid_get_my_projects()`.

At this point, you will have to authenticate to the Collect app. R will
help you do this automatically by opening a browser window for you to
log in to Collect, either via Google sign-in or username and password -
however you normally do\!

Once you’ve logged in, come back to R. Your login credentials will be
stored for a day, until they expire, and you will need to login again.
The package handles the expiration for you, so just log in again when
prompted.

``` r
library(mermaidr)
my_projects <- mermaid_get_my_projects()

my_projects
<<<<<<< HEAD
#> # A tibble: 7 x 14
=======
#> # A tibble: 5 x 14
>>>>>>> Add details on no server authentication to README
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 2d6c… WCS … Mozambiq…        74 "WCS… "Dat… Open   Private         
#> 2 3a9e… Aceh… Indonesia        18 "Vib… ""    Open   Private         
<<<<<<< HEAD
#> 3 507d… Kari… Indonesia        43 "Vib… ""    Open   Public Summary  
#> 4 5679… Mada… Madagasc…        33 "WCS… ""    Open   Public Summary  
#> 5 75ef… Kubu… Fiji             78 "WCS… ""    Open   Private         
#> 6 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
#> 7 a1b7… Grea… Fiji             76 "Fij… ""    Open   Private         
=======
#> 3 5679… Mada… Madagasc…        33 "WCS… ""    Open   Public Summary  
#> 4 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
#> 5 a1b7… Grea… Fiji             76 "Fij… ""    Open   Private         
>>>>>>> Add details on no server authentication to README
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

This function returns information on your projects, including project
countries, the number of sites, tags, data policies, and more.

To filter for specific projects, you can use the `filter` function from
`dplyr`:

``` r
library(dplyr)

indonesia_projects <- my_projects %>%
  filter(countries == "Indonesia")

indonesia_projects
#> # A tibble: 2 x 14
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 3a9e… Aceh… Indonesia        18 "Vib… ""    Open   Private         
<<<<<<< HEAD
#> 2 507d… Kari… Indonesia        43 "Vib… ""    Open   Public Summary  
#> 3 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
=======
#> 2 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
>>>>>>> Add details on no server authentication to README
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

Alternatively, you can search your projects using
`mermaid_search_my_projects()`, narrowing projects down by name,
countries, or tags:

``` r
mermaid_search_my_projects(countries = "Indonesia")
#> # A tibble: 2 x 14
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 3a9e… Aceh… Indonesia        18 "Vib… ""    Open   Private         
<<<<<<< HEAD
#> 2 507d… Kari… Indonesia        43 "Vib… ""    Open   Public Summary  
#> 3 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
=======
#> 2 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
>>>>>>> Add details on no server authentication to README
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

Then, you can start to access data about your projects, like project
sites via `mermaid_get_project_sites()`:

``` r
indonesia_projects %>%
  mermaid_get_project_sites()
<<<<<<< HEAD
#> # A tibble: 98 x 13
#>    project id    name  notes latitude longitude country reef_type reef_zone
#>    <chr>   <chr> <chr> <chr>    <dbl>     <dbl> <chr>   <chr>     <chr>    
#>  1 Karimu… a763… Gent… ""       -5.86     111.  Indone… fringing  back reef
#>  2 Aceh J… 5436… Wisa… ""        5.04      95.4 Indone… fringing  fore reef
#>  3 Aceh J… b7d5… Reha… ""        4.84      95.4 Indone… fringing  fore reef
#>  4 Karimu… 0368… Meny… ""       -5.80     110.  Indone… fringing  fore reef
#>  5 Aceh J… 38f7… Pula… ""        5.08      95.3 Indone… fringing  back reef
#>  6 Karimu… 21ae… Batu… ""       -5.81     110.  Indone… fringing  back reef
#>  7 Karimu… 371b… Tanj… ""       -5.83     110.  Indone… fringing  back reef
#>  8 Karimu… 43d3… Lego… ""       -5.87     110.  Indone… fringing  back reef
#>  9 Karimu… 9ec6… Cema… ""       -5.80     110.  Indone… fringing  back reef
#> 10 Karimu… e23a… Tanj… ""       -5.86     110.  Indone… fringing  back reef
#> # … with 88 more rows, and 4 more variables: exposure <chr>, predecessor <lgl>,
=======
#> # A tibble: 55 x 13
#>    project id    name  notes latitude longitude country reef_type reef_zone
#>    <chr>   <chr> <chr> <chr>    <dbl>     <dbl> <chr>   <chr>     <chr>    
#>  1 Aceh J… 5436… Wisa… ""        5.04      95.4 Indone… fringing  fore reef
#>  2 Aceh J… b7d5… Reha… ""        4.84      95.4 Indone… fringing  fore reef
#>  3 Aceh J… 38f7… Pula… ""        5.08      95.3 Indone… fringing  back reef
#>  4 XPDC K… 340b… KE31  ""       -5.78     133.  Indone… fringing  crest    
#>  5 Aceh J… 026e… Pula… ""        4.78      95.4 Indone… fringing  fore reef
#>  6 Aceh J… 29a2… Ujun… ""        5.12      95.3 Indone… fringing  fore reef
#>  7 Aceh J… 81a0… Inti… ""        4.65      95.6 Indone… fringing  fore reef
#>  8 Aceh J… 9968… Pula… ""        4.88      95.4 Indone… fringing  fore reef
#>  9 Aceh J… ddd6… Pula… ""        4.69      95.5 Indone… fringing  fore reef
#> 10 Aceh J… f96e… Inti… ""        4.83      95.4 Indone… fringing  fore reef
#> # … with 45 more rows, and 4 more variables: exposure <chr>, predecessor <lgl>,
>>>>>>> Add details on no server authentication to README
#> #   created_on <chr>, updated_on <chr>
```

Or the managements for your projects via
`mermaid_get_project_managements()`:

``` r
indonesia_projects %>%
  mermaid_get_project_managements()
<<<<<<< HEAD
#> # A tibble: 20 x 17
=======
#> # A tibble: 14 x 17
>>>>>>> Add details on no server authentication to README
#>    project id    name  name_secondary notes est_year no_take periodic_closure
#>    <chr>   <chr> <chr> <chr>          <chr>    <int> <lgl>   <lgl>           
#>  1 Aceh J… 0f0f… Open  ""             ""        2019 FALSE   FALSE           
#>  2 Aceh J… 1498… Tour… ""             ""        2019 TRUE    FALSE           
#>  3 Aceh J… 646c… Fish… ""             ""        2019 FALSE   FALSE           
#>  4 Aceh J… a579… Aqua… ""             ""        2019 FALSE   FALSE           
#>  5 Aceh J… a803… Open… ""             ""        2019 FALSE   FALSE           
#>  6 Aceh J… cc92… Core… ""             ""        2019 TRUE    FALSE           
#>  7 Aceh J… dce8… Reha… ""             ""        2019 TRUE    FALSE           
<<<<<<< HEAD
#>  8 Karimu… 12bf… Core… ""             ""        2005 TRUE    FALSE           
#>  9 Karimu… 402f… Prot… ""             ""        2012 TRUE    FALSE           
#> 10 Karimu… 53a6… Open… ""             ""        2005 FALSE   FALSE           
#> 11 Karimu… 8b90… Fish… ""             ""        2005 FALSE   FALSE           
#> 12 Karimu… a7e2… Tour… ""             ""        2005 FALSE   FALSE           
#> 13 Karimu… bd73… Reha… ""             ""        2005 FALSE   TRUE            
#> 14 XPDC K… 04fc… Outs… "Control"      ""          NA FALSE   FALSE           
#> 15 XPDC K… 592e… Limi… "Use Zone"     ""          NA FALSE   FALSE           
#> 16 XPDC K… 9ad0… Tour… "No Take Zone" ""          NA TRUE    FALSE           
#> 17 XPDC K… 9bd6… Capt… "Use Zone"     ""          NA FALSE   FALSE           
#> 18 XPDC K… a0a3… Mari… "Use Zone"     ""          NA FALSE   FALSE           
#> 19 XPDC K… c19f… Aqua… "Use Zone"     ""          NA FALSE   FALSE           
#> 20 XPDC K… c2cb… Core… "No Take Zone" ""          NA TRUE    FALSE           
=======
#>  8 XPDC K… 04fc… Outs… "Control"      ""          NA FALSE   FALSE           
#>  9 XPDC K… 592e… Limi… "Use Zone"     ""          NA FALSE   FALSE           
#> 10 XPDC K… 9ad0… Tour… "No Take Zone" ""          NA TRUE    FALSE           
#> 11 XPDC K… 9bd6… Capt… "Use Zone"     ""          NA FALSE   FALSE           
#> 12 XPDC K… a0a3… Mari… "Use Zone"     ""          NA FALSE   FALSE           
#> 13 XPDC K… c19f… Aqua… "Use Zone"     ""          NA FALSE   FALSE           
#> 14 XPDC K… c2cb… Core… "No Take Zone" ""          NA TRUE    FALSE           
>>>>>>> Add details on no server authentication to README
#> # … with 9 more variables: open_access <lgl>, size_limits <lgl>,
#> #   gear_restriction <lgl>, species_restriction <lgl>, compliance <chr>,
#> #   predecessor <lgl>, parties <chr>, created_on <chr>, updated_on <chr>
```

### Method data

You can also currently access data on your projects’ fish belt and
benthic PIT methods, with more methods to come. The details are in the
following sections.

#### Fish Belt data

To access fish belt data for a project, use `mermaid_get_project_data()`
with `method = "fishbelt"`.

You can access individual observations (i.e., a record of each
observation) by setting `data = "observations"`:

``` r
xpdc <- my_projects %>%
  filter(name == "XPDC Kei Kecil 2018")

xpdc %>%
  mermaid_get_project_data(method = "fishbelt", data = "observations")
<<<<<<< HEAD
#> # A tibble: 3,069 x 47
=======
#> # A tibble: 3,069 x 46
>>>>>>> Add details on no server authentication to README
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  3 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  4 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  5 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
<<<<<<< HEAD
#>  6 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  8 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  9 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 10 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> # … with 3,059 more rows, and 39 more variables: reef_exposure <chr>,
=======
#>  6 XPDC K… NA    Indone… KE10     -5.57      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE23     -5.80      133. fringing  fore reef
#>  8 XPDC K… NA    Indone… KE15     -5.62      133. fringing  crest    
#>  9 XPDC K… NA    Indone… KE28     -5.75      133. patch     fore reef
#> 10 XPDC K… NA    Indone… KE11     -5.59      133. fringing  crest    
#> # … with 3,059 more rows, and 38 more variables: reef_exposure <chr>,
>>>>>>> Add details on no server authentication to README
#> #   reef_slope <chr>, tide <chr>, current <chr>, visibility <chr>,
#> #   relative_depth <chr>, management <chr>, management_secondary <chr>,
#> #   management_est_year <lgl>, management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   sample_time <chr>, transect_length <int>, transect_width <chr>,
#> #   size_bin <chr>, observers <chr>, depth <dbl>, transect_number <int>,
#> #   label <chr>, fish_family <chr>, fish_genus <chr>, fish_taxon <chr>,
#> #   size <dbl>, biomass_constant_a <dbl>, biomass_constant_b <dbl>,
#> #   biomass_constant_c <dbl>, count <int>, biomass_kgha <dbl>,
#> #   trophic_level <dbl>, functional_group <chr>, vulnerability <dbl>,
#> #   data_policy_beltfish <chr>, project_notes <chr>, site_notes <chr>,
#> #   management_notes <chr>, contact_link <chr>
```

You can access sample units data, which are observations aggregated to
the sample units level. Fish belt sample units contain total biomass in
kg/ha per sample unit, by trophic group:

``` r
xpdc %>%
  mermaid_get_project_data("fishbelt", "sampleunits")
#> # A tibble: 246 x 40
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  3 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  4 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  5 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  6 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  8 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  9 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#> 10 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#> # … with 236 more rows, and 39 more variables: reef_exposure <chr>,
#> #   reef_slope <chr>, tide <chr>, current <chr>, visibility <chr>,
#> #   relative_depth <chr>, management <chr>, management_secondary <chr>,
#> #   management_est_year <lgl>, management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   sample_time <chr>, depth <dbl>, transect_number <int>, label <chr>,
#> #   size_bin <chr>, transect_length <int>, transect_width <chr>,
#> #   biomass_kgha <dbl>, biomass_kgha_by_trophic_group$omnivore <dbl>,
#> #   $piscivore <dbl>, $planktivore <dbl>, $`invertivore-mobile` <dbl>,
#> #   $`herbivore-detritivore` <dbl>, $`invertivore-sessile` <dbl>,
#> #   $`herbivore-macroalgae` <dbl>, $other <dbl>, data_policy_beltfish <chr>,
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>,
#> #   sample_event_notes <chr>, sample_event_id <chr>, sample_unit_ids <chr>,
#> #   id <lgl>, contact_link <chr>
```

And finally, sample events data, which are aggregated further, to the
sample event level. Fish belt sample events contain *mean* total biomass
in kg/ha per sample event and by trophic group:

``` r
xpdc_sample_events <- xpdc %>%
  mermaid_get_project_data("fishbelt", "sampleevents")

xpdc_sample_events
#> # A tibble: 46 x 28
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  3 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#>  4 XPDC K… NA    Indone… KE05     -5.47      133. fringing  crest    
#>  5 XPDC K… NA    Indone… KE06     -5.52      132. fringing  crest    
#>  6 XPDC K… NA    Indone… KE07     -5.57      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE08     -5.55      133. fringing  crest    
#>  8 XPDC K… NA    Indone… KE09     -5.60      133. fringing  fore reef
#>  9 XPDC K… NA    Indone… KE10     -5.57      133. fringing  crest    
#> 10 XPDC K… NA    Indone… KE11     -5.59      133. fringing  crest    
#> # … with 36 more rows, and 27 more variables: reef_exposure <chr>,
#> #   management <chr>, management_secondary <chr>, management_est_year <lgl>,
#> #   management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   depth_avg <dbl>, biomass_kgha_avg <dbl>,
#> #   biomass_kgha_by_trophic_group_avg$omnivore <dbl>, $piscivore <dbl>,
#> #   $planktivore <dbl>, $`invertivore-mobile` <dbl>,
#> #   $`herbivore-detritivore` <dbl>, $`invertivore-sessile` <dbl>,
#> #   $`herbivore-macroalgae` <dbl>, $other <dbl>, data_policy_beltfish <chr>,
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>,
#> #   sample_event_notes <chr>, id <chr>, sample_unit_count <int>,
#> #   contact_link <chr>
```

##### A note on saving data

Both the sample units and sample events data contain a “data-frame
column” (`biomass_kgha_by_trophic_group` and
`biomass_kgha_by_trophic_group_avg`, respectively). In order to save
this data in a file like a CSV or XLSX, you will need to expand this
column first.

This can be done with a function from the `mermaidreporting` package,
`mermaid_clean_columns()`:

``` r
library(mermaidreporting)

xpdc_sample_events_clean <- xpdc_sample_events %>%
  mermaid_clean_columns()

xpdc_sample_events_clean
#> # A tibble: 46 x 35
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  3 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#>  4 XPDC K… NA    Indone… KE05     -5.47      133. fringing  crest    
#>  5 XPDC K… NA    Indone… KE06     -5.52      132. fringing  crest    
#>  6 XPDC K… NA    Indone… KE07     -5.57      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE08     -5.55      133. fringing  crest    
#>  8 XPDC K… NA    Indone… KE09     -5.60      133. fringing  fore reef
#>  9 XPDC K… NA    Indone… KE10     -5.57      133. fringing  crest    
#> 10 XPDC K… NA    Indone… KE11     -5.59      133. fringing  crest    
#> # … with 36 more rows, and 27 more variables: reef_exposure <chr>,
#> #   management <chr>, management_secondary <chr>, management_est_year <lgl>,
#> #   management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   depth_avg <dbl>, biomass_kgha_avg <dbl>, omnivore <dbl>, piscivore <dbl>,
#> #   planktivore <dbl>, invertivore_mobile <dbl>, herbivore_detritivore <dbl>,
#> #   invertivore_sessile <dbl>, herbivore_macroalgae <dbl>, other <dbl>,
#> #   data_policy_beltfish <chr>, project_notes <chr>, site_notes <chr>,
#> #   management_notes <chr>, sample_event_notes <chr>, id <chr>,
#> #   sample_unit_count <int>, contact_link <chr>
```

Then, you can save the data:

``` r
library(readr)

write_csv(xpdc_sample_events_clean, "xpdc_sample_events_clean.csv")
```

#### Benthic PIT data

Accessing Benthic PIT data works the exact same way as Fish Belt data,
except you change `method` to “benthicpit”:

``` r
xpdc %>%
  mermaid_get_project_data(method = "benthicpit", data = "observations")
#> # A tibble: 11,100 x 40
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  3 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  4 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  5 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  6 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  8 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  9 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> 10 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#> # … with 11,090 more rows, and 32 more variables: reef_exposure <chr>,
#> #   reef_slope <chr>, tide <chr>, current <chr>, visibility <chr>,
#> #   relative_depth <chr>, management <chr>, management_secondary <chr>,
#> #   management_est_year <lgl>, management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   sample_time <chr>, depth <dbl>, transect_number <int>,
#> #   transect_length <int>, interval_start <dbl>, interval_size <dbl>,
#> #   label <chr>, observers <chr>, interval <dbl>, benthic_category <chr>,
#> #   benthic_attribute <chr>, growth_form <chr>, data_policy_benthicpit <chr>,
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>,
#> #   observation_notes <chr>, contact_link <chr>
```

You can access sample units and sample events the same way.

For Benthic PIT, sample units contain percent cover per sample unit, by
benthic category. Sample *events* contain *mean* percent cover per
sample event, by benthic category.

You can return both of these by setting the `data` argument. This will
return a list of two data frames: one containing sample units, and the
other sample events.

``` r
xpdc_sample_units_events <- xpdc %>%
  mermaid_get_project_data(method = "benthicpit", data = c("sampleunits", "sampleevents"))

names(xpdc_sample_units_events)
#> [1] "sampleunits"  "sampleevents"
xpdc_sample_units_events[["sampleunits"]]
#> # A tibble: 111 x 40
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  3 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  4 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  5 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  6 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  7 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#>  8 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#>  9 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#> 10 XPDC K… NA    Indone… KE05     -5.47      133. fringing  crest    
#> # … with 101 more rows, and 39 more variables: reef_exposure <chr>,
#> #   reef_slope <chr>, tide <chr>, current <chr>, visibility <chr>,
#> #   relative_depth <chr>, management <chr>, management_secondary <chr>,
#> #   management_est_year <lgl>, management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   sample_time <chr>, depth <dbl>, transect_number <int>,
#> #   transect_length <int>, label <chr>, interval_start <dbl>,
#> #   interval_size <dbl>, observers <chr>,
#> #   percent_cover_by_benthic_category$Sand <dbl>, $Rubble <dbl>, $`Hard
#> #   coral` <dbl>, $Macroalgae <dbl>, $`Soft coral` <dbl>, $`Turf algae` <dbl>,
#> #   $`Other invertebrates` <dbl>, $`Bare substrate` <dbl>,
#> #   data_policy_benthicpit <chr>, project_notes <chr>, site_notes <chr>,
#> #   management_notes <chr>, sample_event_notes <chr>, sample_event_id <chr>,
#> #   sample_unit_ids <chr>, id <lgl>, contact_link <chr>
```

#### Multiple methods data

To pull data for both fish belt and benthic PIT methods, you can set
`method` to include both.

``` r
xpdc_sample_events <- xpdc %>%
  mermaid_get_project_data(method = c("fishbelt", "benthicpit"), data = "sampleevents")
```

The result is a list of data frames, containing sample events for both
fish belt and benthic PIT methods:

``` r
names(xpdc_sample_events)
#> [1] "fishbelt"   "benthicpit"

xpdc_sample_events[["benthicpit"]]
#> # A tibble: 38 x 27
#>    project tags  country site  latitude longitude reef_type reef_zone
#>    <chr>   <lgl> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#>  1 XPDC K… NA    Indone… KE02     -5.44      133. fringing  crest    
#>  2 XPDC K… NA    Indone… KE03     -5.61      132. fringing  crest    
#>  3 XPDC K… NA    Indone… KE04     -5.58      132. fringing  crest    
#>  4 XPDC K… NA    Indone… KE05     -5.47      133. fringing  crest    
#>  5 XPDC K… NA    Indone… KE06     -5.52      132. fringing  crest    
#>  6 XPDC K… NA    Indone… KE07     -5.57      133. fringing  crest    
#>  7 XPDC K… NA    Indone… KE08     -5.55      133. fringing  crest    
#>  8 XPDC K… NA    Indone… KE09     -5.60      133. fringing  fore reef
#>  9 XPDC K… NA    Indone… KE10     -5.57      133. fringing  crest    
#> 10 XPDC K… NA    Indone… KE11     -5.59      133. fringing  crest    
#> # … with 28 more rows, and 26 more variables: reef_exposure <chr>,
#> #   management <chr>, management_secondary <chr>, management_est_year <lgl>,
#> #   management_size <lgl>, management_parties <lgl>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   depth_avg <dbl>, percent_cover_by_benthic_category_avg$Sand <dbl>,
#> #   $Rubble <dbl>, $`Hard coral` <dbl>, $Macroalgae <dbl>, $`Soft coral` <dbl>,
#> #   $`Turf algae` <dbl>, $`Other invertebrates` <dbl>, $`Bare substrate` <dbl>,
#> #   data_policy_benthicpit <chr>, project_notes <chr>, site_notes <chr>,
#> #   management_notes <chr>, sample_event_notes <chr>, id <chr>,
#> #   sample_unit_count <int>, contact_link <chr>
```

Alternatively, you can set `method` to “all” to pull for all methods\!
This will be handy once there are more than two methods. Similarly, you
can set `data` to “all” to pull all types of data:

``` r
all_project_data <- xpdc %>%
  mermaid_get_project_data(method = "all", data = "all", limit = 1)

names(all_project_data)
#> [1] "fishbelt"          "benthiclit"        "benthicpit"       
#> [4] "bleaching"         "habitatcomplexity"

names(all_project_data[["benthicpit"]])
#> [1] "observations" "sampleunits"  "sampleevents"
```

#### Multiple projects

Pulling data for multiple projects is the exact same, except there will
be an additional “project” column at the beginning to distinguish which
projects the data comes from. Recall that `my_projects` contains four
projects:

``` r
my_projects
<<<<<<< HEAD
#> # A tibble: 7 x 14
=======
#> # A tibble: 5 x 14
>>>>>>> Add details on no server authentication to README
#>   id    name  countries num_sites tags  notes status data_policy_bel…
#>   <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#> 1 2d6c… WCS … Mozambiq…        74 "WCS… "Dat… Open   Private         
#> 2 3a9e… Aceh… Indonesia        18 "Vib… ""    Open   Private         
<<<<<<< HEAD
#> 3 507d… Kari… Indonesia        43 "Vib… ""    Open   Public Summary  
#> 4 5679… Mada… Madagasc…        33 "WCS… ""    Open   Public Summary  
#> 5 75ef… Kubu… Fiji             78 "WCS… ""    Open   Private         
#> 6 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
#> 7 a1b7… Grea… Fiji             76 "Fij… ""    Open   Private         
=======
#> 3 5679… Mada… Madagasc…        33 "WCS… ""    Open   Public Summary  
#> 4 9de8… XPDC… Indonesia        37 ""    "XPD… Open   Private         
#> 5 a1b7… Grea… Fiji             76 "Fij… ""    Open   Private         
>>>>>>> Add details on no server authentication to README
#> # … with 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

``` r
my_projects %>%
  mermaid_get_project_data("fishbelt", "sampleevents", limit = 1)
<<<<<<< HEAD
#> # A tibble: 7 x 28
#>   project tags  country site  latitude longitude reef_type reef_zone
#>   <chr>   <chr> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#> 1 WCS Mo… WCS … Mozamb… Aqua…   -21.8       35.5 barrier   back reef
#> 2 Aceh J… WCS … Indone… Abah…     4.99      95.4 fringing  fore reef
#> 3 Karimu… WCS … Indone… Batu…    -5.81     110.  fringing  back reef
#> 4 Madaga… WCS … Madaga… Anta…   -16.4       49.8 fringing  fore reef
#> 5 Kubula… WCS … Fiji    C13     -17.0      179.  barrier   fore reef
#> 6 XPDC K… <NA>  Indone… KE02     -5.44     133.  fringing  crest    
#> 7 Great … Fiji… Fiji    BA02    -17.4      178.  atoll     back reef
#> # … with 27 more variables: reef_exposure <chr>, management <chr>,
#> #   management_secondary <chr>, management_est_year <int>,
#> #   management_size <dbl>, management_parties <chr>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   depth_avg <dbl>, biomass_kgha_avg <dbl>,
#> #   biomass_kgha_by_trophic_group_avg$piscivore <dbl>, $planktivore <dbl>,
#> #   $`invertivore-mobile` <dbl>, $`herbivore-detritivore` <dbl>,
#> #   $omnivore <dbl>, $`invertivore-sessile` <dbl>,
#> #   $`herbivore-macroalgae` <dbl>, $other <dbl>, data_policy_beltfish <chr>,
=======
#> # A tibble: 5 x 29
#>   project tags  country site  latitude longitude reef_type reef_zone
#>   <chr>   <chr> <chr>   <chr>    <dbl>     <dbl> <chr>     <chr>    
#> 1 WCS Mo… WCS … Mozamb… Bunt…   -12.6       40.6 fringing  fore reef
#> 2 Aceh J… WCS … Indone… Pula…     4.78      95.4 fringing  fore reef
#> 3 Madaga… WCS … Madaga… Anta…   -16.4       49.8 fringing  fore reef
#> 4 XPDC K… <NA>  Indone… KE02     -5.44     133.  fringing  crest    
#> 5 Great … Fiji… Fiji    BA09    -17.4      178.  atoll     back reef
#> # … with 28 more variables: reef_exposure <chr>, tide <chr>, current <chr>,
#> #   visibility <chr>, management <chr>, management_secondary <chr>,
#> #   management_est_year <int>, management_size <lgl>, management_parties <chr>,
#> #   management_compliance <chr>, management_rules <chr>, sample_date <date>,
#> #   depth_avg <dbl>, biomass_kgha_avg <dbl>,
#> #   biomass_kgha_by_trophic_group_avg$piscivore <dbl>, $planktivore <dbl>,
#> #   $`invertivore-mobile` <dbl>, $`herbivore-detritivore` <dbl>, $other <dbl>,
#> #   $omnivore <dbl>, $`invertivore-sessile` <dbl>,
#> #   $`herbivore-macroalgae` <dbl>, data_policy_beltfish <chr>,
>>>>>>> Add details on no server authentication to README
#> #   project_notes <chr>, site_notes <chr>, management_notes <chr>,
#> #   sample_event_notes <chr>, id <chr>, sample_unit_count <int>,
#> #   contact_link <chr>
```

Note the `limit` argument here, which just limits the data pulled to one
record (per project, method, and data combination). This is useful if
you want to get a preview of what your data will look like without
having to pull it all in.

### Accessing non-project data

You may also want to access data that is not related to projects. To
access this data, you do not need to authenticate R with MERMAID.

For example, you can pull reference data (the names and information of
the fish and benthic attributes you can choose in MERMAID), using
`mermaid_get_reference()`:

``` r
mermaid_get_reference(reference = "fishfamilies")
#> # A tibble: 162 x 8
#>    id    name  status biomass_constan… biomass_constan… biomass_constan…
#>    <chr> <chr> <chr>             <dbl>            <dbl>            <dbl>
#>  1 0091… Kyph… Open            0.0194              3.03            0.989
#>  2 00b6… Mugi… Open            0.0164              2.96            0.973
#>  3 00f4… Zena… Open            0.00427             3.02            1    
#>  4 0226… Sphy… Open            0.00329             3.15            1    
#>  5 0880… Labr… Open            0.0119              3.04            0.998
#>  6 0aff… Scom… Open            0.0108              3.05            0.992
#>  7 0b69… Ophi… Open            0.00144             2.92            1    
#>  8 0d99… Albu… Open            0.0105              2.99            1    
#>  9 0e5b… Hemi… Open            0.0490              3.16            0.987
#> 10 1513… Serr… Open            0.0138              3.03            0.997
#> # … with 152 more rows, and 2 more variables: created_on <chr>,
#> #   updated_on <chr>
```

Using this function, you can access the fish family, fish genera, fish
species, and benthic attributes references by changing the `reference`
argument.

You can also get a list of *all* projects (not just your own):

``` r
mermaid_get_projects()
#> # A tibble: 93 x 14
#>    id    name  countries num_sites tags  notes status data_policy_bel…
#>    <chr> <chr> <chr>         <int> <chr> <chr> <chr>  <chr>           
#>  1 01bb… Mada… "Madagas…        12 "WCS… "Sur… Open   Private         
#>  2 07df… Cend… "Indones…        36 "Cen… ""    Open   Private         
#>  3 0c00… 2019… "Fiji"           18 "WCS… ""    Open   Private         
#>  4 0c16… REEF… ""                0 ""    ""    Open   Public Summary  
#>  5 0f17… what  ""                0 ""    ""    Open   Public Summary  
#>  6 124b… Sam   ""                0 ""    ""    Open   Private         
#>  7 170e… 2018… "Fiji"           10 "WCS… "Thi… Open   Private         
#>  8 1a49… Comm… ""                0 "WCS… "Thi… Open   Private         
#>  9 1c0b… Base… "Indones…        11 "WCS… "Bas… Open   Public Summary  
#> 10 1d3a… Thau… ""                0 ""    "I a… Open   Public Summary  
#> # … with 83 more rows, and 6 more variables: data_policy_benthiclit <chr>,
#> #   data_policy_benthicpit <chr>, data_policy_habitatcomplexity <chr>,
#> #   data_policy_bleachingqc <chr>, created_on <chr>, updated_on <chr>
```

As well as all sites:

``` r
mermaid_get_sites()
#> # A tibble: 1,888 x 13
#>    id    name  notes project latitude longitude country reef_type reef_zone
#>    <chr> <chr> <chr> <chr>      <dbl>     <dbl> <chr>   <chr>     <chr>    
#>  1 0235… BA09  ""    a1b7ff…    -17.4      178. Fiji    atoll     back reef
#>  2 03e5… BA03  ""    89f2d4…    -17.4      178. Fiji    atoll     back reef
#>  3 0879… BA16  ""    a1b7ff…    -17.2      178. Fiji    atoll     back reef
#>  4 1925… BA15  ""    a1b7ff…    -17.2      178. Fiji    atoll     back reef
#>  5 19e6… YA02  ""    a1b7ff…    -17.0      177. Fiji    atoll     back reef
#>  6 20ae… BA11  ""    a1b7ff…    -17.3      178. Fiji    atoll     back reef
#>  7 2831… BA06  ""    89f2d4…    -17.4      178. Fiji    atoll     back reef
#>  8 2a46… BA04  ""    89f2d4…    -17.4      178. Fiji    atoll     back reef
#>  9 2af4… BA12  ""    a1b7ff…    -17.3      178. Fiji    atoll     back reef
#> 10 2c31… BA05  ""    89f2d4…    -17.4      178. Fiji    atoll     back reef
#> # … with 1,878 more rows, and 4 more variables: exposure <chr>,
#> #   predecessor <chr>, created_on <chr>, updated_on <chr>
```

And all managements:

``` r
mermaid_get_managements()
#> # A tibble: 472 x 17
#>    id    name  name_secondary rules notes est_year no_take periodic_closure
#>    <chr> <chr> <chr>          <chr> <chr>    <int> <lgl>   <lgl>           
#>  1 0260… Dawa… ""             Open… ""          NA FALSE   FALSE           
#>  2 02cd… Kaib… ""             Peri… ""        2017 FALSE   TRUE            
#>  3 02e5… VIR3  ""             No T… ""        2012 TRUE    FALSE           
#>  4 03ba… VIR9  ""             No T… ""        2016 TRUE    FALSE           
#>  5 04e2… Bu_O… ""             Open… ""          NA FALSE   FALSE           
#>  6 04fc… Outs… "Control"      Open… ""          NA FALSE   FALSE           
#>  7 0543… LV02  ""             No T… ""          NA TRUE    FALSE           
#>  8 05a4… Cons… ""             No T… ""          NA TRUE    FALSE           
#>  9 05ec… Ra_t… ""             Peri… ""        2012 FALSE   TRUE            
#> 10 066e… Kana… ""             Open… ""          NA FALSE   FALSE           
#> # … with 462 more rows, and 9 more variables: open_access <lgl>,
#> #   size_limits <lgl>, gear_restriction <lgl>, species_restriction <lgl>,
#> #   compliance <chr>, predecessor <chr>, parties <chr>, created_on <chr>,
#> #   updated_on <chr>
```

### Other data

There is additional data available from the MERMAID API, both related to
specific projects and not. If you think you’ll need to use these, please
see the help for them by typing `?mermaid_get_endpoint` or
`?mermaid_get_project_endpoint`.
