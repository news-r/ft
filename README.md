
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/news-r/ft.svg?branch=master)](https://travis-ci.org/news-r/ft)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/news-r/ft?branch=master&svg=true)](https://ci.appveyor.com/project/news-r/ft)
<!-- badges: end -->

# ft

Brings the [FT](https://www.ft.com/) Search API to R.

## Installation

You can install the package from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("news-r/ft")
```

## Setup

Create a free account at [developer.ft.com](https://developer.ft.com) to
create an API key.

``` r
ft_key("xxXXxxXx")
```

Note that you can specify the `FT_API_KEY` key as an environment
variable in your `.Renviron` for convenience.

## Example

``` r
library(ft)
#> API key loaded!

# search 2 pages of articles "banks"
banks <- ft_search("banks", pages = 2)

# search titles of articles on "debates" and not Trump
debates <- ft_search("debates -Trump", curations = "ARTICLES", aspects = "title")
head(debates)
#> # A tibble: 6 x 5
#>   aspectSet modelVersion id           apiUrl             title             
#>   <chr>     <chr>        <chr>        <chr>              <chr>             
#> 1 article   1            d164166c-96… https://api.ft.co… Hunt tells Johnso…
#> 2 article   1            c173831e-96… https://api.ft.co… Mercosaurus hunti…
#> 3 article   1            3d28b29e-93… https://api.ft.co… Howard Marks fear…
#> 4 article   1            a7eff752-92… https://api.ft.co… Dance festival wr…
#> 5 article   1            85fc694c-92… https://api.ft.co… How Oxford univer…
#> 6 article   1            cebad0ac-93… https://api.ft.co… Sajid Javid knock…
```

You can learn more about the possible `curations`, `aspects`, `facets`,
`searchable`, and `sortable` with `?discover` which describes functions
that return vectors of valid filters.

``` r
ft_list_curations()
#> [1] "ARTICLES" "BLOGS"    "PAGES"    "PODCASTS" "VIDEOS"
```
