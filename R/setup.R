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
#' @import httr
#' @import assertthat
#' 
#' @name setup
#' @export
ft_key <- function(key){
  assert_that(!missing(key), msg = "Missing key")
  Sys.setenv(FT_API_KEY = key)
}
