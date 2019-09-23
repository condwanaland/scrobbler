context("Test URL constructor")

test_urls <- c("http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=1",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=2",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=3",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=4",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=5",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=6",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=7",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=8",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=9",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=10",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=11",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=12",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=13",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=14",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=15"
)

test_that("constructor correctly creates api links", {
  expect_equal(test_urls, construct_urls(15, "RScrobblerUser", 123456789))
})
