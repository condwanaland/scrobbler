## Test environments
* local OS X install, R 3.5.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## This is a 2nd resubmission. In this version I have

* Rewritten the description to explain 'last.fm' and 'scrobbles' in more detail.

* Eliminated as many /dontrun{} as possible. The single remaining one is in `fetch_tracks`, and thats because the run time can be lengthy. To compensate I have added another vignette titled "Example Workflow" that gives a runnable example of using `fetch_tracks`.

## This is a resubmission. In this version I have

* Added a link to last.fm in the description using angle brackets. 
* No longer specified a default directory for the outfile. Outfile must now be explicitly supplied, or an error is thrown
