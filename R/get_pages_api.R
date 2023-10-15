#' download_scrobbles
#'
#' @param username Your last.fm account username
#' @param api_key Your last.fm account api key
#'
#' @return A dataframe of songs and associated metadata
#' @export
#'
#' @examples
#' \dontrun{
#' download_scrobbles(username = "your_username", api_key = "your_api_key")
#' }
download_scrobbles <- function(username = get_lastfm_credentials('username'),
                               api_key = get_lastfm_credentials('key')){

  # Call the API, extract the total number of pages, store in variable
  tracks <- get_total_pages(username, api_key)
  total_pages = tracks[[1]]
  print(paste("Total number of pages:", total_pages))
  print("Starting scrobble downloads...")

  # Use total page info to construct one URL for each page
  all_urls <- construct_urls(total_pages, username, api_key)

  # Run the downloads
  long_data <- run_downloads(total_pages, all_urls)

}

#' update_scrobbles
#'
#' Companion function to `download_scrobbles`. Only downloads the scrobbles that have been
#' stored since you ran `download_scrobbles`.
#'
#' @param data A dataframe outputted by `download_scrobbles`
#' @param timestamp_column The `date_unix` column in your dataframe
#' @param username Last.fm API username
#' @param api_key Last.fm API key
#'
#' @return A dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' mydat <- download_scrobbles(username = "your_username", api_key = "your_api_key")
#' update_dat <- update_scrobbles(mydat,
#'     "date_unix",
#'     username = "your_username",
#'     api_key = "your_api_key")
#' }
update_scrobbles <- function(data,
                             timestamp_column,
                             username = get_lastfm_credentials('username'),
                             api_key = get_lastfm_credentials('key')){

  last_timestamp <- get_last_timestamp(data, timestamp_column)

  total_pages <- get_total_pages(username, api_key, from = last_timestamp)[[1]]

  all_urls <- construct_urls(total_pages, username, api_key, from = last_timestamp)

  long_data <- run_downloads(total_pages, all_urls)

  all_data <- rbind(data, long_data)

  return(all_data)

}


#' run_downloads
#'
#' @param total_pages Total number of pages your scrobbles is spread over
#' @param all_urls The output of `construct_urls`
#'
#' @return
#' @noRd
run_downloads <- function(total_pages, all_urls){
  # Initialise a vector of 1 to total number of pages. Used for the progress counter
  counter <- seq_along(1:total_pages)

  # Send request to the API, repeatedly trying if a 200 is not returned
  all_dat <- mapply(function(x, y){
    repeat {
      api_response <- httr::GET(x)
      if (api_response$status_code == 500){
        print(paste0("Failed to parse page ", counter[y], ", retrying"))
      }
      if (api_response$status_code == 200) break
    }
    print(paste0("Page ", counter[y], "/", total_pages, " successfully parsed"))
    return(api_response)
  }, x = all_urls, y = counter, SIMPLIFY = FALSE)

  # Extract content as text
  all_dat <- lapply(all_dat, function(x){
    httr::content(x, as = "text", encoding = "UTF-8")
  })

  # Turn json into dataframe (flatten nested columns)
  all_dat <- lapply(all_dat, function(x){
    jsonlite::fromJSON(x, flatten = TRUE)
  })

  # Extract just the songs and metadata
  parsed_dat <- lapply(all_dat, function(x){
    x[["recenttracks"]][["track"]]
  })

  parsed_dat <- lapply(parsed_dat, function(x){
    x[, c("mbid", "name", "artist.mbid", "artist.#text", "album.mbid",
          "album.#text", "date.uts", "date.#text")]
  })

  # Bind each sub-data frame into one long one
  long_data <- do.call(rbind, parsed_dat)

  # Remove unnecessary columns
  #long_data$image <- NULL
  #long_data$streamable <- NULL
  #long_data$url <- NULL
  #long_data$X.attr.nowplaying <- NULL
  rownames(long_data) <- NULL
  #long_data$date.uts <- NULL

  # Set useful names
  long_data <- rename_api_response(long_data)

  return(long_data)

}
