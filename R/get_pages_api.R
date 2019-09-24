#' download_scrobbles
#'
#' @param username Your last.fm account username
#' @param api_key Your last.fm account api key
#'
#' @return A dataframe of songs and assoicated metadata
#' @export
#'
#' @examples
#' \dontrun{
#' download_scrobbles(username = "your_username", api_key = "your_api_key")
#' }

download_scrobbles <- function(username, api_key){

  # Call the API, extract the total number of pages, store in variable
  tracks <- get_total_pages(username, api_key)
  total_pages = tracks[[1]]
  print(paste("Total number of pages:", total_pages))
  print("Starting scrobble downloads...")

  # Use total page info to construct one URL for each page
  all_urls <- construct_urls(total_pages, username, api_key)

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

  # Bind each sub-data frame into one long one
  long_data <- do.call(rbind, parsed_dat)

  # Remove unnecessary columns
  long_data$image <- NULL
  long_data$streamable <- NULL
  long_data$url <- NULL
  long_data$date.uts <- NULL

  # Set useful names
  long_data <- rename_api_response(long_data)

  return(long_data)

}
