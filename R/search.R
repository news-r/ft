#' Calls
#' 
#' The content endpoint returns all pieces of content in the API.
#' 
#' @param q The search query.
#' @param ... Any other parameter.
#' @param pages Number of pages to collect from \code{start_at_page}.
#' @param start_at_page Initial page.
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
    resultContext = list(
      maxResults = 100
    ),
    ...
  )

  # url
  url <- parse_url(BASE_URL)
  url$path <- c("content", "search", "v1")
  url$query <- list(apiKey = .get_key())
  url <- build_url(url)

  results <- tibble::tibble()
  for(off in offsets){
    body$resultContext$offset <- off
    response <- POST(url, body = body, encode = "json")
    stop_for_status(response)
    content <- content(response)
    content_df <- content$results[[1]]$results %>% 
      purrr::map_dfr(tibble::as_tibble)
    results <- dplyr::bind_rows(results, content_df)
  }
  results
}
