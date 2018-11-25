#' fetch_tracks
#'
#' Runs a script in your working directory called 'lastexport.py'
#'
#' @return
#' @export
#'
#' @examples

fetch_tracks <- function(username, out_file, start_page){

  # Arguments must be quoted - check that everything is a character
  check_args_are_chr(username, out_file, start_page)

  # Store args as objects to be used later
  u <- username
  o <- out_file
  s <- start_page

  # Check that start_page can be successfully converted to numeric
  tryCatch({
    as.numeric(start_page)},
    warning = function(w){
      stop("start_page could not be converted to a whole number")
    },
    error = function(e){
      stop("start_page could not be converted to a whole number")
    }
  )

  invisible()
}

