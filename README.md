---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



<!-- badges: start -->
[![Travis build status](https://travis-ci.org/news-r/ft.svg?branch=master)](https://travis-ci.org/news-r/ft)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/news-r/ft?branch=master&svg=true)](https://ci.appveyor.com/project/news-r/ft)
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

Create a free account at [developer.ft.com](https://developer.ft.com) to create an API key.

```r
ft_key("xxXXxxXx")
```

Note that you can specify the `FT_API_KEY` key as an environment variable in your `.Renviron` for convenience.


## Example


```r
library(ft)

# search 2 pages of articles "banks"
banks <- ft_search("banks", pages = 2)

# search titles of articles on "debates" and not Trump
debates <- ft_search("debates -Trump", curations = "ARTICLES", aspects = "title")
head(debates)
#> # A tibble: 6 x 5
#>   aspectSet modelVersion id           apiUrl             title             
#>   <chr>     <chr>        <chr>        <chr>              <chr>             
#> 1 article   1            d88d769e-8a… https://api.ft.co… US tech CEOs join…
#> 2 article   1            28d321ab-89… https://api.ft.co… Sweeping reform n…
#> 3 article   1            533db1f4-87… https://api.ft.co… Saudi business fe…
#> 4 article   1            aa7ca41c-86… https://api.ft.co… It’s easy to forg…
#> 5 article   1            3cb9f0b0-87… https://api.ft.co… Instagram atheist…
#> 6 article   1            48ecd7b4-88… https://api.ft.co… South Africa’s ra…
```
