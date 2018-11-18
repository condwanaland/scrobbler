#' setup_scrobbler
#'
#' Place python file fetching scrobbled tracks into your working directory
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' library(musicr)
#' setup_scrobbler()
#' }

setup_scrobbler <- function(){
  fileloc <- system.file("scripts", "lastexport.py", package = "musicr")
  mywd <- getwd()

  file.copy(fileloc, mywd, overwrite = T)
}


