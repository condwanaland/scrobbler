#' check_py_script
#'
#' Checks that the py script to scrape tracks exists in your working directory
#'
#' @param py_version Which version of python you want to use. One of '2' or '3'.
#'
#' @return Character vector
#' @export
#'
#' @examples
#' check_py_script(2)
#' check_py_script("3")

check_py_script <- function(py_version){
  py_version <- as.character(py_version)
  if(!py_version %in% c("2", "3")){
    stop("Please specify one of '2' or '3'")
  }
  if (py_version == "3"){
    if (!file.exists("lastexport.py")){
      return("Python 3 exporter does not exist")
    }
    return("Python 3 exporter exists")
  }

  else if (py_version == "2"){
    if(!file.exists("lastexport2.py")){
      return("Python 2 exporter does not exist")
    }
    return("Python 2 exporter exists")
  }
}

#' find_py_script
#'
#' Returns the file path to a py script
#'
#' @param version One of '2' or '3'. Specifies which version of python you will be running
#'
#' @return File path
#' @export
#'
#' @examples
#' find_py_script(version = "3")

find_py_script <- function(version){
  if (!version %in% c("2", "3")){
    stop("Must be one of '2' or '3'")
  }
  if (version == "2"){
    return(system.file("scripts", "lastexport2.py", package = "scrobbler"))
  }
  return(system.file("scripts", "lastexport.py", package = "scrobbler"))
}



#' install_export_script
#'
#' Copies the script used to scrape scrobbles into your working directory. Necessary in order
#' to run 'fetch_tracks'
#'
#' @param version Which version of python to run. One of '2' or '3'.
#'
#' @return Invisibly returns TRUE or FALSE, indicating whether the file copy was successful.
#' @export
#'
#' @examples
#' install_scrobble_script(version = "3")


install_scrobble_script <- function(version){
  py_script_path <- find_py_script(version)
  mydir <- getwd()

  file.copy(py_script_path, mydir)
  invisible()
}

