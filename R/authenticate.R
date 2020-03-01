#' get_lastfm_credentials
#'
#' @param env One of 'username' or 'key', to return the username or key environment variable respectively
#'
#' @return Character string
#' @export
#'
#' @examples
#' \dontrun{
#' get_lastfm_credentials(env = 'username')
#' get_lastfm_credentials(env = 'key')
#' }
get_lastfm_credentials <- function(env){

  if (!env %in% c("username", "key")){
    stop("env must be one of 'username' or 'key", call. = FALSE)
  }

  check_env_vars()

  if (env == "username"){
    val <- Sys.getenv('LASTFM_API_USERNAME')
  }
  else if (env == 'key'){
    val <- Sys.getenv('LASTFM_API_KEY')
  }

  return(val)
}

#' check_env_vars
#'
#' @noRd
check_env_vars <- function(){
  username_val <- Sys.getenv('LASTFM_API_USERNAME')
  key_val <- Sys.getenv('LASTFM_API_KEY')

  if (username_val == "" || key_val == ""){
    stop("'LASTFM_API_USERNAME' and/or 'LASTFM_API_KEY' environment variables are not set.
         Set them with 'Sys.setenv() or pass these variables explicitly.", call. = FALSE)
  }
  else return(TRUE)
}
