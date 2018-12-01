# nocov start
#' py_version
#'
#' Returns the version of python you are using
#'
#' @return Character vector
#' @export
#'
#' @examples
#' py_version()

py_version <- function(){
  system2("python", "-V")
}


#' py_path
#'
#' Returns the path to your python installation
#'
#' @return Character vector
#' @export
#'
#' @examples
#' py_path()

py_path <- function(){
  if (check_os() == "windows"){
    system2("where", "python")
  }
  system2("which", "python")
}



#' check_os
#'
#' @return Character vector
#' @noRd
#'
#' @examples
#' check_os()

check_os <- function(){
 if (Sys.info()["sysname"] == "Darwin") {
   return("mac")
 }
 else if (.Platform$OS.type == "windows") {
   return("windows")
 }
 else if (.Platform$OS.type == "unix") {
   return("linux")
 }
 else stop("Could not determine os type")
}

#nocov end
