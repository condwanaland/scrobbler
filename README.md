[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/) [![codecov](https://codecov.io/gh/condwanaland/scrobbler/branch/master/graph/badge.svg)](https://codecov.io/gh/condwanaland/scrobbler) [![Build Status](https://travis-ci.org/condwanaland/scrobbler.svg?branch=master)](https://travis-ci.org/condwanaland/scrobbler) [![](https://www.r-pkg.org/badges/version/scrobbler)](https://www.r-pkg.org:443/pkg/scrobbler)

# scrobbler

`scrobbler` is an R package intended to help people download their scrobbles from Last.fm and run an analysis on their listening history.


### What on earth are scrobbles?

[Scrobbling](https://www.last.fm/about/trackmymusic) is a way of tracking the history of all the songs you listen to online or locally by using the [Last.fm](https://www.last.fm/home) service. While scrobbling originated as a way of recorded what you had listened to on the Last.fm platform, scrobbling is now possible on a range of platforms such as Spotify, Youtube, iTunes, Soundcloud, and most other listening platforms. In all these cases, any scrobbles are still stored on Last.fm's platform. If you use multiple services for listening to music, you can set up scrobbling on all of them, and use Last.fm as the central hub of your entire listening history.

For example, if your a spotify user you can create a Last.fm account, navigate to https://www.last.fm/settings/applications, and click the option to conncet your spotify account. Now, anytime you listen to music on spotify, the song, artist, album, and time will be recorded on Last.fm.


### Why scrobbler?

Last.fm's webpage is pretty good at providing you some summary statistics about what you've been listening to, and who your most played artists are. However, I wanted to be able to get the raw data to analyse myself. Unfortunately, Last.fm does not provide any way for you to automatically download your scrobbles. 


### How to use scrobbler

**Note as of version 0.2.15**: `scrobbler` has recently undergone a major API change. In earlier versions there was an option to install a python script and run that to download your scrobbles. This option has been removed, and the only supported method is going via the `Last.fm` API. The 'old' version is available as a github release. 

You can download the latest version of `scrobbler` from CRAN with
```
install.packages("scrobbler")
```

Or grab the development version from github with
```
devtools::install_github("condwanaland/scrobbler")
```


### Setting up the API

In order to use Last.fm' API you need to get an API key from Last.fm. This takes less than 5 mins, and can be done [here](https://www.last.fm/api/account/create)

Once you have your key and username, you can start downloading your scrobbles


### Downloading scrobbles

To make a dataframe of all your scrobbled tracks, simply call `download_scrobbles` using your Last.fm username and API key.
```
library(scrobbler)
my_data <- download_scrobbles(username = "your_username", api_key = "your_api_key")
```

### Updating scrobbles

Once you have a lot of scrobbled tracks it can often take a long time to download them all. It would be a waste of time to have to re-download your entire history of scrobbles everytime you wanted to update. 

To help with this, `scrobbler` provides the `update_scrobbles` function. This function takes a dataframe produced by `download_scrobbles`, and only fetches the tracks that have been scrobbled since you ran `download_scrobbles`. 
```
my_updated_data <- update_scrobbles(my_data, 
                                    timestamp_column = 'unix_date',
                                    username = "your_username",
                                    api_key = "your_api_key")
```

`unix_date` is a column outputted by `download_scrobbles`. It tracks the timestamp of each song, and needs to be passed to `update_scrobbles` so it knows where to start getting new tracksr from. 
