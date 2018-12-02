[![codecov.io](https://codecov.io/github/r-lib/covr/coverage.svg?branch=master)](https://codecov.io/github/condwanaland/scrobbler?branch=master)


`scrobbler` is an R package intended to help people download their scrobbles from Last.fm and run an analysis on their listening history.


### What on earth are scrobbles?

[Scrobbling](https://www.last.fm/about/trackmymusic) is a way of tracking the history of all the songs you listen to online or locally by using the [Last.fm](https://www.last.fm/home) service. While scrobbling originated as a way of recorded what you had listened to on the Last.fm platform, scrobbling is now possible on a range of platforms such as Spotify, Youtube, iTunes, Soundcloud, and most other listening platforms. In all these cases, any scrobbles are still stored on Last.fm's platform. If you use multiple services for listening to music, you can set up scrobbling on all of them, and use Last.fm as the central hub of your entire listening history.

For example, if your a spotify user you can create a Last.fm account, navigate to https://www.last.fm/settings/applications, and click the option to conncet your spotify account. Now, anytime you listen to music on spotify, the song, artist, album, and time will be recorded on Last.fm.


### Why scrobbler?

Last.fm's webpage is pretty good at providing you some summary statistics about what you've been listening to, and who your most played artists are. However, I wanted to be able to get the raw data to analyse myself. Unfortunately, Last.fm does not provide any way for you to automatically download your scrobbles. 

Simple package to help me setup R projects that need my music tracks exported from the Last.fm scrobble list.

The API of this program is not terribly intuitive/useful, due to me not understanding how to modify the parameters of a python script when called from R. In the future I hope to modify this package so it can more easily be used by others to fetch their own tracks.

This package is completely dependent on the fantastic 'lastexport.py' python script that is found here: <https://github.com/encukou/lastscrape-gui>. All credit for the web scraping goes fully to the author of that repo.


Workflow

Figure out if you have python
`py_version` to figure out what version of python you have
`py_path` to figure out what the path to your python installation is

Install the script to export your scrobbles
`install_scrobble_script` with your preferred python version

Download tracks
`fetch_tracks` to download scrobbles
