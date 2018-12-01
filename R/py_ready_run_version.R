#' py_ready
#'
#' Checks whether directory is ready to donwload scrobbles
#'
#' @return NULL
#' @noRd
#'

py_ready <- function(){
  if ((!file.exists("lastexport.py")) && (!file.exists("lastexport2.py"))) {
    stop("No 'lastexport' script detected. Try running 'install_scrobble_script'",
        call. = FALSE)
  }
}


#' py_version_to_run
#'
#' Determines the name of the py script to run
#'
#' @return Either 'lastexport.py' for python 3 or 'lastexport2.py' for python2
#' @noRd
#'

py_version_to_run <- function(){
  if (file.exists("lastexport2.py")){
    ver <- "lastexport2.py"
  }

  if (file.exists("lastexport.py")){
    ver <- "lastexport.py"
  }

  return(ver)
}
