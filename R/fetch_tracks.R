#' fetch_tracks
#'
#' Runs a script in your working directory called 'lastexport.py'
#'
#' @return
#' @export
#'
#' @examples
#' if(file.exists(lastexport.py){
#' fetch_tracks(lastexport.py)})

fetch_tracks <- function(){
  reticulate::use_python("//anaconda/bin/python", required = T)
  reticulate::source_python("lastexport.py")
}
