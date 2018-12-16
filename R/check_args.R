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
    error = function(e) stop("All arguments must be supplied as characters", call. = FALSE))
}



#' check_start_page_to_numeric
#'
#' @param start_page
#'
#'@noRd
#'

check_start_page_to_numeric <- function(start_page){
  tryCatch({
    as.integer(start_page)},
    warning = function(w){
      stop("start_page could not be converted to a whole number")
    },
    error = function(e){
      stop("start_page could not be converted to a whole number")
    }
  )
}
