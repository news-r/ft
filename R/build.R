#' Calls
#' 
#' The content endpoint returns all pieces of content in the API.
#' 
#' @param since The start date and time: any content created, updated or deleted since this date should be returned. 
#' A valid since parameter must be supplied, and it must be either a \code{Date} or \code{POSIX} object. 
#' The date and time must not be in the future, and cannot be older than 90 days from the present.
#' @param pages Number of pages to collect.
#' 
#' @examples
#' \dontrun{
#' (to_search <- gd_search("debates", pages = 13))
#' results <- gd_call(to_search)
#' 
#' # select items to retrieve
#' items_to_get <- gd_items(results$apiUrl[1:13])
#' items <- gd_call(items_to_get)
#' }
#' 
#' @name calls
#' @export
ft_search <- function(q, ..., pages = 1, start_at_page = 1) {
  
  # process inputs
  init_offset <- start_at_page - 1
  offsets <- (((seq(pages) * 100) + 1) + (init_offset * 100)) - 100
  body <- list(
    queryString = q, 
    maxResults = 100
  )

  # url
  url <- parse_url(BASE_URL)
  url$path <- c("content", "search", "v1")
  url$query <- list(apiKey = .get_key())
  url <- build_url(url)

  results <- list()
  for(off in offsets){
    body$offset <- off
    response <- POST(url, body = body)
    stop_for_status(response)
    content <- content(response)
    results <- append(results, list(content))
  }
  results
}