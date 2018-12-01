#' fetch_tracks
#'
#' Runs a script in your working directory called 'lastexport.py'
#'
#' @param username Username of last.fm account to fetch scrobbles from
#' @param out_file Name of output file to save tracks to (i.e., scrobbles.txt)
#' @param start_page Page to start from. Defaults to 1
#'
#' @return
#' @export
#'
#' @examples

fetch_tracks <- function(username, out_file, start_page = NULL){

  # Arguments must be quoted - check that everything is a character
  check_args_are_chr(username, out_file, start_page)

  # Check that start_page can be successfully converted to numeric
  check_start_page_to_numeric(start_page)

  # Store args as objects to be used later
  u <- username
  o <- out_file
  s <- start_page


  invisible()
}

