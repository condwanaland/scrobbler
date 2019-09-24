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
  text_response <- httr::content(response, "text", encoding = "UTF-8")
  parsed = jsonlite::fromJSON(text_response, flatten = TRUE)


  total_pages = as.integer(parsed[["recenttracks"]][["@attr"]][["totalPages"]])
  page_1 = parsed[["recenttracks"]][["track"]]

  return(list(total_pages,
              page_1))
}

#' construct_urls
#'
#' @param total_pages Total number of pages to build
#' @param username Your username
#' @param api_key Your api_key
#'
#' @return Vector of urls
#' @noRd
#'
construct_urls <- function(total_pages, username, api_key){
  result <- vector("character")

  for (page in seq_along(1:total_pages)){
    urls <- paste0(
      "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=",
      username,
      "&limit=1000&api_key=",
      api_key,
      "&format=json&page=",
      page
    )
    result[page] <- urls
  }
  return(stats::na.omit(result))
}


#' rename_api_response
#'
#' Takes the parsed response from the Last.fm API and renames the columns to make them user
#' friendly.
#'
#' @param api_data An api response that has been parsed by the `download_scrobbles` function.
#'
#' @return A renamed dataframe
#' @noRd
rename_api_response <- function(api_data){
  names(api_data)[names(api_data) == "name"] <- "song_title"
  names(api_data)[names(api_data) == "mbid"] <- "song_mbid"
  names(api_data)[names(api_data) == "artist.mbid"] <- "artist_mbid"
  names(api_data)[names(api_data) == "artist.#text"] <- "artist"
  names(api_data)[names(api_data) == "album.mbid"] <- "album_mbid"
  names(api_data)[names(api_data) == "album.#text"] <- "album"
  names(api_data)[names(api_data) == "date.#text"] <- "date"
  return(api_data)
}