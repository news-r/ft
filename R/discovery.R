#' Discover Methods
#' 
#' Useful lists to further filter \code{\link{ft_search}}.
#' 
#' @examples
#' \dontrun{
#' ft_list_aspects()  
#' }
#' 
#' @name discover
#' @export
ft_list_aspects <- function(){
  .dicover("aspects")
}

#' @rdname discover
#' @export
ft_list_curations <- function(){
  .dicover("curations")
}

#' @rdname discover
#' @export
ft_list_facets <- function(){
  .dicover("facets")
}

#' @rdname discover
#' @export
ft_list_searchable <- function(){
  .dicover(c("field", "searchable"))
}

#' @rdname discover
#' @export
ft_list_sortable <- function(){
  .dicover(c("field", "sortable"))
}

.dicover <- function(endpoint) {
  url <- parse_url(BASE_URL)
  url$path <- c("content", "search", endpoint, "v1")
  url$query <- list(apiKey = .get_key())
  url <- build_url(url)
  response <- GET(url)
  stop_for_status(response)
  content(response) %>% 
    unlist()
}
