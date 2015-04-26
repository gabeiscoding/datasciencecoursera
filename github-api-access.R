library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
client_id <- "eab8cda46b0f0d727488"
client_secret <- "a1c8ad7189af192063e5ecc938f0e295e856510f"
myapp <- oauth_app("github", client_id, secret=client_secret)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
c <- content(req)
reponames <- sapply(c, function(x) x$name)
c[[match("datasharing", reponames)]]$created_at
