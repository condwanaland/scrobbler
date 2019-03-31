#' get_total_pages
#'
#' Returns the total number of pages that your song list spans across. Used for determining
#' how many pages to loop the api call over
#'
#' @param username Your `Last.fm` username, as a string
#' @param api_key Your `Last.fm` api_key, as a string
#'
#' @return A single number character string
#' @noRd

get_total_pages <- function(username, api_key){
  print("Getting page numbers...")
  base_url <- paste0(
    "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=",
    username,
    "&limit=1000&api_key=",
    api_key,
    "&format=json"
  )

  response <- httr::GET(base_url)
  parsed_response <- httr::content(response, "parsed")

  return(parsed_response[["recenttracks"]][["@attr"]][["totalPages"]])
}
