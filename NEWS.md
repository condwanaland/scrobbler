# scrobbler 0.2.13.9000

* Added a `NEWS.md` file to track changes to the package.

* Added an `update_scrobbles` function. Unlike `download_scrobbles`, this function takes the dataframe output of `download_scrobbles`, and a timestamp column (needs to be the `time_unix`) column, and only downloads the scrobbles that have been logged since you last downloaded your scrobbles. This presents a large speed increase, as you no longer need to keep re-downloading all your old scrobbles by repeatedly running `download_scrobbles`. 

* Added deprecation warnings to functions that call and use the python scripts. These will be fully removed in the next version, making the API call the only supported method. Currently, only tests/helpers are removed
