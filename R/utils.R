BASE_URL <- "https://api.ft.com"

.get_key <- function() {
  key <- Sys.getenv("FT_API_KEY")
  assert_that(nchar(key) > 1, msg = "Missing key, see `ft_key`")
  return(key)
}

.construct_call <- function(calls){
  assert_that(!missing(calls), msg = "Missing calls")
  structure(calls, class = c(class(calls), "guardianCalls"))
}

.build_calls <- function(..., pages = 1, endpoint = "search") {
  parsed_url <- parse_url(BASE_URL)
  parsed_url$path <- endpoint
  query <- list(..., `api-key` = .get_key())
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