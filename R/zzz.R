.onAttach <- function(...) {
  key <- Sys.getenv("FT_API_KEY")

  msg <- "No API key found, see `ft_key`"
  if(nchar(key) > 1) msg <- "API key loaded!"

  packageStartupMessage(msg)
}