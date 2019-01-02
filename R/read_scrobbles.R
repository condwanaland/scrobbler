#' read_scrobbles
#'
#' Wrapper around read_delim to correctly read a scrobbled tracks file.
#'
#' @param file A .txt file from the output of `fetch_tracks`
#' @param convert_time One of 'None', 'Date', 'Time'. Determines what format to put the Date
#' column in. Either as a datestamp ('Date'), timestamp ('Time'), or (the default) left as a
#' UNIX timestamp ('None').
#' @param ... Additional arguments to pass to `read_delim`
#'
#' @return A dataframe
#' @export
#'
#' @examples
#' my_tracks <- read_scrobbles(system.file("extdata", "scrobbles.txt", package = "scrobbler"),
#' convert_time = "Date")

read_scrobbles <- function(file, convert_time = "None", ...){

  if(!convert_time %in% c("None", "Date", "Time")){
    stop("Must be one of 'None', 'Date', 'Time'")
  }

  dat <- utils::read.delim(file, header = FALSE, sep = "\t", ...)
  colnames(dat) <- c("Date", "Song", "Artist", "Album",
                     "Song_mb_id", "Artist_mb_id", "Album_mb_id")

  if (convert_time == "None"){
    return(dat)
  }
  else if (convert_time == "Date"){
    dat$Date <- anytime::anydate(dat$Date)
    return(dat)
  }
  dat$Date <- anytime::anytime(dat$Date)
  return(dat)
}


#' convert
#'
#' Convert a unix timestamp to either a datestamp or timestamp
#'
#' @param unix_col A column in a dataframe of 10 digit unix numbers.
#' @param to One of 'Date' or 'Time'. Determines whether you get a datestamp of timestamp.
#' @param ... Additional arguments to be passed to anytime::anytime or anytime::anydate.
#'
#' @return Date vector
#' @export
#'
#' @examples
#' unix_time <- "1522124746"
#' timestamp <- convert(unix_time, to = "Time")
#'
#'
#' my_tracks <- read_scrobbles(system.file("extdata", "scrobbles.txt", package = "scrobbler"))
#' my_tracks$Date <- convert(my_tracks$Date, to = "Time")


convert <- function(unix_col, to, ...){
  if(!to %in% c("Date", "Time")){
    stop("to must be one of 'Date' or 'Time'")
  }

  if (to == "Date"){
    date_col <- anytime::anydate(unix_col, ...)
    return(date_col)
  }
  time_col <- anytime::anytime(unix_col, ...)
  return(time_col)
}
