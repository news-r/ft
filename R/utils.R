BASE_URL <- "https://api.ft.com"

.get_key <- function() {
  key <- Sys.getenv("FT_API_KEY")
  assert_that(nchar(key) > 1, msg = "Missing key, see `ft_key`")
  return(key)
}

.parse <- function(x){
  x <- map(x, function(row){
    if(length(row) > 0) 
      row <- unlist(row)
    return(row) 
  })
  tibble::as_tibble(x)
}