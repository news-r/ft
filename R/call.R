#' Call
#' 
#' Executes calls from \code{ftCalls} objects
#' 
#' @param ... Objects of class \code{ftCalls}.
#' @param batch_size Size of each batch.
#' 
#' @examples
#' \dontrun{
#' (to_search <- gd_search("debates", pages = 15))
#' results <- gd_call(to_search)
#' }
#' 
#' @export
gd_call <- function(..., batch_size = 12) UseMethod("gd_call")

#' @rdname gd_call
#' @method gd_call guardianCalls
#' @export
gd_call.ftCalls <- function(..., batch_size = 10){
  
  # flatten calls
  call_objs <- list(...) %>% 
    flatten()

  # compute size
  size <- (length(call_objs) %/% batch_size) + 1

  cat(
    crayon::blue(cli::symbol$info), "Making", length(call_objs), "calls in", crayon::green(size), "batches of", batch_size, "\n"
  )

  calls <- map(call_objs, "call")
  endpoint <- map(call_objs, "endpoint")
  
  calls %>% 
    split(rep_len(1:size, length(calls))) %>% 
    map(unlist) %>% 
    .call_map()
  
}

.http_warn_for_status <- function(response){
  if(response$status_code != 200){
    warning(crayon::red(cli::symbol$cross), " Call error", call. = FALSE)
  }
  return(response)
}

.call <- function(batch) {

  http_response <- function(url) {
    http_get(url)$
      then(.http_warn_for_status)$
      then(function(response) rawToChar(response$content))$
      then(function(response) jsonlite::fromJSON(response))
  }

  async_map(batch, http_response)
}

.call_map <- function(batches){
  batches %>% 
    map(
    function(x){
      if(length(batches) > 1)
        Sys.sleep(3)
      synchronise(.call(x))
    }
  ) %>% 
    flatten() %>% 
    map("response") %>% 
    map(function(response){
      if(length(response$content))
        return(response$content)
      return(response$results)
    }) %>% 
    map_dfr(dplyr::bind_rows)
}