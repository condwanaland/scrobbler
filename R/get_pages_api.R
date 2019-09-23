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
  text_response <- httr::content(response, "text")
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

  for (page in 1:total_pages){
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


#' collect_tracks
#'
#' @param username Your last.fm account username
#' @param api_key Your last.fm account api key
#'
#' @return A dataframe of songs and assoicated metadata
#' @export
#'
#' @examples
#' \dontrun{
#' collect_tracks(username = "your_username", api_key = "your_api_key)
#' }

collect_tracks <- function(username, api_key){

  # Call the API, extract the total number of pages, store in variable
  tracks <- get_total_pages(username, api_key)
  total_pages = tracks[[1]]

  # Use total page info to construct one URL for each page
  all_urls <- construct_urls(total_pages, username, api_key)

  # Hit API once for each page (no pagination in API), and parse response
  all_dat <- lapply(all_urls, function(x){
    httr::GET(x)
  })

  # Extract content as text
  all_dat <- lapply(all_dat, function(x){
    httr::content(x, "text")
  })

  # Turn json into dataframe (flatten nested columns)
  all_dat <- lapply(all_dat, function(x){
    jsonlite::fromJSON(x, flatten = TRUE)
  })

  parsed_dat <- lapply(all_dat, function(x){
    x[["recenttracks"]][["track"]]
  })

  # Bind each sub-data frame into one long one
  long_data <- do.call(rbind, parsed_dat)

  # Remove unnecessary columns
  long_data$image <- NULL
  long_data$streamable <- NULL
  long_data$url <- NULL
  long_data$date.uts <- NULL

  # Set useful names
  names(long_data)[names(long_data) == "name"] <- "song_title"
  names(long_data)[names(long_data) == "mbid"] <- "song_mbid"
  names(long_data)[names(long_data) == "artist.mbid"] <- "artist_mbid"
  names(long_data)[names(long_data) == "artist.#text"] <- "artist"
  names(long_data)[names(long_data) == "album.mbid"] <- "album_mbid"
  names(long_data)[names(long_data) == "album.#text"] <- "album"
  names(long_data)[names(long_data) == "date.#text"] <- "date"

  return(long_data)

}
