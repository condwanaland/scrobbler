#' check_args_are_chr
#'
#' Checks whether params passed down from fetch_tracks are supplied as quoted characters
#'
#' @noRd
#'

check_args_are_chr <- function(username, out_file, start_page = NULL){
  tryCatch({
    stopifnot(is.character(username),
              is.character(out_file),
              is.character(start_page) || is.null(start_page))},
    error = function(e) stop("Arguments must be supplied as characters"))
}
