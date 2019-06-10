#' Setup
#' 
#' Setup your session, all subsequent calls will be done using the API key.
#'
#' @param key Your API key, freely available at \url{https://developer.ft.com}.
#' 
#' @note You can specify \code{FT_API_KEY} as environment variable, likely in your \code{.Renviron} file.
#' 
#' @examples
#' \dontrun{
#' guardian_key("xXXxxXxXxXXx")  
#' }
#' 
#' @import purrr
#' @import async
#' @import httr
#' @import assertthat
#' 
#' @name setup
#' @export
ft_key <- function(key){
  assert_that(!missing(key), msg = "Missing key")
  Sys.setenv(FT_API_KEY = key)
}


.construct_call <- function(calls){
  assert_that(!missing(calls), msg = "Missing calls")
  structure(calls, class = c(class(calls), "ftCalls"))
}

.build_calls <- function(..., pages = 1, endpoint = "search") {
  parsed_url <- parse_url(BASE_URL)
  parsed_url$path <- endpoint
  query <- list(..., apiKey = .get_key())
  calls <- seq(pages) %>% 
    map(function(p){
      query$page <- p
      parsed_url$query <- query
      build_url(parsed_url) 
    }) %>% 
      map(function(x){
        list(
          call = x,
          endpoint = endpoint
        )
      })
  .construct_call(calls)
}