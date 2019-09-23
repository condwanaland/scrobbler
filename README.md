[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![codecov](https://codecov.io/gh/condwanaland/scrobbler/branch/master/graph/badge.svg)](https://codecov.io/gh/condwanaland/scrobbler) [![Build Status](https://travis-ci.org/condwanaland/scrobbler.svg?branch=master)](https://travis-ci.org/condwanaland/scrobbler) [![](http://www.r-pkg.org/badges/version/scrobbler)](http://www.r-pkg.org/pkg/scrobbler)

## scrobbler

`scrobbler` is an R package intended to help people download their scrobbles from Last.fm and run an analysis on their listening history.


### What on earth are scrobbles?

[Scrobbling](https://www.last.fm/about/trackmymusic) is a way of tracking the history of all the songs you listen to online or locally by using the [Last.fm](https://www.last.fm/home) service. While scrobbling originated as a way of recorded what you had listened to on the Last.fm platform, scrobbling is now possible on a range of platforms such as Spotify, Youtube, iTunes, Soundcloud, and most other listening platforms. In all these cases, any scrobbles are still stored on Last.fm's platform. If you use multiple services for listening to music, you can set up scrobbling on all of them, and use Last.fm as the central hub of your entire listening history.

For example, if your a spotify user you can create a Last.fm account, navigate to https://www.last.fm/settings/applications, and click the option to conncet your spotify account. Now, anytime you listen to music on spotify, the song, artist, album, and time will be recorded on Last.fm.


### Why scrobbler?

Last.fm's webpage is pretty good at providing you some summary statistics about what you've been listening to, and who your most played artists are. However, I wanted to be able to get the raw data to analyse myself. Unfortunately, Last.fm does not provide any way for you to automatically download your scrobbles. 


### How to use scrobbler

You can download `scrobbler` from github as follows

```
install.packages("devtools")

devtools::install_github("condwanaland/scrobbler")
```

`scrobbler` relies on you having a python installation on your computer. It can support python 2 and 3, but I highly recommend you get a python 3 installation and attach it to your PATH variable. For instructions with this, please check the vignette.

Once you've determined whether you want to run the python 2 or 3 script, you can use

```
scrobbler::install_scrobble_script(version = )
```
where version equals either "2" or "3".

This will install the python script in your working directory. You can then run

```
scrobbler::fetch_tracks(username = "username", out_file = "scrobbles.txt")
```
where `username` equals your last.fm username. This will download a txt file called "scrobbles.txt" containing your scrobbles. This is quite a slow process (it takes me about 4 mins to download ~10,000 scrobbles) so don't worry if it looks like your computer is hanging. 

Once the tracks are downloaded, you can use

```
scrobbler::read_scrobbles()
```

to read in your txt file as a formatted dataframe. `read_scrobbles` also has a `convert_time` argument to specify what format you want the scrobbles timestamp to be.


Once this is completed, you now have a clean dataframe of your listening history to analyse as you please.


### Scrobbling via the API

If you do not want to setup a python installation on your computer, you can also fetch your scrobbles by using the Last.fm API. 

This requires you to get an API key from Last.fm. This takes less than 5 mins, and can be done [here](https://www.last.fm/api/account/create)

Once you have your key, you can use the `collect_tracks` function to create a dataframe of your scrobbled songs

```
my_data <- scrobbler::collect_tracks(username = "your_username", api_key = "your_api_key")
```


### Acknowledgements

This package is completely dependent on the fantastic 'lastexport.py' python script that is found here: <https://github.com/encukou/lastscrape-gui>, and the 'lastexport.py' script that is found here: <https://github.com/hanshenrik/music-when>. All credit for the python code in this package goes to the authors of those repos. 
