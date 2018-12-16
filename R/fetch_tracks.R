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

