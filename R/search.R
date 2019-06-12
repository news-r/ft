#' Calls
#' 
#' The content endpoint returns all pieces of content in the API.
#' 
#' @param q The search query.
#' @param curations FT content is organised into curations which you can use to filter your search, 
#' you can get the full list of valid curations with \code{\link{ft_list_curations}}.
#' @param facets Filter search by specific facets, see \code{\link{ft_list_facets}} for a full list.
#' @param sort_aspect,sort_order \code{sort_aspect} must be a valid aspect,
#' see \code{\link{ft_list_aspects}} while \code{sort_order} must be set to either 
#' \code{ASC} OR \code{DESC}. Note that they must be used together.
#' @param aspects Aspects (vector or list) to return, see \code{\link{ft_list_aspects}} for a list of valid values.
#' @param pages Number of pages to collect from \code{start_at_page}.
#' @param start_at_page Initial page.
#' 
#' @examples
#' \dontrun{
#' banks <- ft_search("banks", pages = 2) # search 2 pages of articles "banks"
#'
#' # search titles of articles on "debates" and not Trump
#' debates <- ft_search("debates -Trump", curations = "ARTICLES", aspects = "title")
#' }
#' 
#' @seealso Official documentation: \url{https://developer.ft.com/portal/docs-api-v1-reference-search-search-api-tutorial}.
#' 
#' @name calls
#' @export
ft_search <- function(q, curations = NULL, facets = NULL, aspects = NULL, 
  sort_aspect = NULL, sort_order = NULL, pages = 1, start_at_page = 1) {

  sort <- sum(!is.null(sort_aspect), !is.null(sort_order))
  if(sort == 1)
    stop("Arguments `sort_field` and `sort_order` must be used together", call. = FALSE)

  # process inputs
  init_offset <- start_at_page - 1
  offsets <- (((seq(pages) * 100) + 1) + (init_offset * 100)) - 100
  body <- list(
    queryString = q, 
    resultContext = list(
      maxResults = 100
    )
  )

  if(!is.null(aspects)) 
    body$resultContext$aspects <- as.list(aspects)

  if(!is.null(facets)) 
    body$resultContext$facets <- facets

  if(!is.null(sort_aspect)) 
    body$resultContext$sortField <- sort_aspect

  if(!is.null(sort_order)) 
    body$resultContext$sortOrder <- sort_order

  if(!is.null(sort_order)) 
    body$queryContext$curations <- curations


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
      purrr::map_dfr(.parse)
    results <- dplyr::bind_rows(results, content_df)
  }
  results
}
