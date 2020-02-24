context("Test URL constructor")

test_urls <- c("http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=1&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=2&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=3&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=4&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=5&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=6&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=7&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=8&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=9&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=10&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=11&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=12&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=13&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=14&from=0",
               "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&user=RScrobblerUser&limit=1000&api_key=123456789&format=json&page=15&from=0"
)

test_that("constructor correctly creates api links", {
  expect_equal(test_urls, construct_urls(15, "RScrobblerUser", 123456789))
})
