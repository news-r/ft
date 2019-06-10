BASE_URL <- "https://api.ft.com"

.get_key <- function() {
  key <- Sys.getenv("FT_API_KEY")
  assert_that(nchar(key) > 1, msg = "Missing key, see `ft_key`")
  return(key)
}
