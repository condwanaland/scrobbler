#' check_args_are_chr
#'
#' Checks whether params passed down from fetch_tracks are supplied as quoted characters
#'
#' @noRd
#'

check_args_are_chr <- function(username, out_file, start_page){
  tryCatch({
    stopifnot(is.character(username),
              is.character(out_file),
              is.character(start_page))},
    error = function(e) stop("Arguments must be supplied as characters"))
}


checker <- function(arg1){
  if (is.character(arg1) == FALSE && is.null(arg1) == FALSE){
    stop("Arg not correct")
  }
  print("got here")
}

checker(NULL)


check_args_are_chr <- function(arg1, arg2){
  tryCatch({
    stopifnot(is.character(arg1), is.character(arg2) && is.null(arg2))},
    error = function(e) stop("Arguments must be supplied as characters"))

}

check_args_are_chr2("one", NULL)
