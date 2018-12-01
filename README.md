[![codecov.io](https://codecov.io/github/r-lib/covr/coverage.svg?branch=master)](https://codecov.io/github/condwanaland/scrobbler?branch=master)


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
