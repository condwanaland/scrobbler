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

  # Start by looping over 2nd page - 1st page is returned by the get_total_pages function
  for (page in 2:total_pages){
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


collect_tracks <- function(username, api_key){
  #pb <- progress_bar$new(total = 100)
  #pb$tick(0)

  tracks <- get_total_pages(username, api_key)
  total_pages = tracks[[1]]

  all_urls <- construct_urls(total_pages, username, api_key)

  all_dat <- lapply(all_urls, function(x){
    httr::GET(x)
  })

  all_dat <- lapply(all_dat, function(x){
    httr::content(x, "text")
  })

  all_dat <- lapply(all_dat, function(x){
    jsonlite::fromJSON(x, flatten = TRUE)
  })

  parsed_dat <- lapply(all_dat, function(x){
    x[["recenttracks"]][["track"]]
  })

  long_data <- do.call(rbind, parsed_dat)
  long_data <- rbind(tracks[[2]], long_data)

  long_data$image <- NULL
  long_data$streamable <- NULL
  long_data$url <- NULL
  long_data$date.uts <- NULL

  col_names <- c("song", "song_mbid", "artist_mbid", "artist", "album_mbid", "album", "date")
  colnames(long_data) <- col_names

  return(long_data)

}

#mydat <- collect_tracks('condwanaland', api_key)
#
# data2 <- do.call(rbind, mydat)

# data_dat <- lapply(parsed_dat, function(x){
#   x[["recenttracks"]][["track"]]
# })
#
# new_dat_list <- lapply(data_dat2, function(x) do.call(cbind, x))
#
# data2 <- do.call(rbind, new_dat_list)
#
# bound_dat <- data.table::rbindlist(data_dat)
# bound_dat <- dplyr::bind_rows(data_dat)
#
# dat1 <- data_dat[[1]]
# dat2 <- data_dat[[2]]
# dat3 <- dplyr::bind_rows(dat1, dat2)
#
# dat1$image <- NULL
# dat1$date <- NULL
# dat1$streamable <- NULL
#
# dat2$image <- NULL
# dat2$date <- NULL
# dat2$streamable <- NULL
#
# row.names(dat1) <- NULL
# row.names(dat2) <- NULL
#
# rbind(dat1, dat2)
#
#
# all_dat_test <- all_dat
# all_dat_test <- lapply(all_dat_test, function(x){
#   jsonlite::fromJSON(x, flatten = TRUE)
# })
