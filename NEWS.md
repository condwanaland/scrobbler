# scrobbler 1.0.3

* Fixed a longstanding (sorry!) issue where `download_scrobbles` would fail due to differing numbers of columns. Issues is fixed and code is made more robust overall (by explicitly selecting needed columns rather than dropping unneeded ones)

# scrobbler 1.0.2

* Extraneous printing in both download functions has been removed

# scrobbler 1.0.1

* scrobbler now has better authentication options through environment variables. You can set the 'LASTFM_API_USERNAME' and 'LASTFM_API_KEY' variables to avoid having to pass these everytime.

* Any functions for setting up and running scrobble downloads by using python scripts have been removed. Going via the Last.fm API is now the only officially supported method.

* Removed the old python vignette, and added two new ones describing the updated workflow.

# scrobbler 0.2.15

* Added a `NEWS.md` file to track changes to the package.

* Added an `update_scrobbles` function. Unlike `download_scrobbles`, this function takes the dataframe output of `download_scrobbles`, and a timestamp column (needs to be the `time_unix`) column, and only downloads the scrobbles that have been logged since you last downloaded your scrobbles. This presents a large speed increase, as you no longer need to keep re-downloading all your old scrobbles by repeatedly running `download_scrobbles`. 

* Added deprecation warnings to functions that call and use the python scripts. These will be fully removed in the next version, making the API call the only supported method. Currently, only tests/helpers are removed
