#' check_py_script
#'
#' Checks that the py script to scrape tracks exists in your working directory
#'
#' @param py_version Which version of python you want to use. One of '2' or '3'.
#'
#' @return
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

  if (py_version == "2"){
    if(!file.exists("lastexportpy2.py")){
      return("Python 2 exporter does not exist")
    }
    return("Python 2 exporter does not exist")
  }
}

