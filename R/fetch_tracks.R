#' fetch_tracks
#'
#' Runs a script in your working directory called 'lastexport.py'
#'
#' @param username Username of last.fm account to fetch scrobbles from
#' @param out_file Name of output file to save tracks to (i.e., scrobbles.txt)
#' @param start_page Page to start from. Defaults to 1
#'
#' @return .txt file of scrobbled tracks
#' @export
#'
#' @examples
#' \dontrun{
#' fetch_tracks("your_username", out_file = "scrobbles.txt", start_page = 1)
#' }

fetch_tracks <- function(username, out_file, start_page = NULL){
  .Deprecated("download_scrobbles")

  # Arguments must be quoted - check that everything is a character
  check_args_are_chr(username, out_file, start_page)

  # Check that start_page can be successfully converted to numeric
  check_start_page_to_numeric(start_page)

  # Store args as objects to be used later
  u <- username
  o <- out_file
  s <- as.integer(start_page)

  # Check whether there is a py script to run
  py_ready()

  # Determine which version of the script we're gonna run
  ver <- py_version_to_run()


  # Construct the system query
  if (ver == "lastexport2.py"){
    system2("python",
            args = c("lastexport2.py",
                     paste("-u", u)))
  }

  if (ver == "lastexport.py"){
    system2("python",
            args = c("lastexport.py",
                     paste("-u", u),
                     paste("-o", o),
                     paste("-p", s)))
  }

}


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


install_scrobble_script <- function(version){
  .Deprecated("download_scrobbles")

  py_script_path <- find_py_script(version)
  mydir <- getwd()

  file.copy(py_script_path, mydir)
  invisible()
}


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
