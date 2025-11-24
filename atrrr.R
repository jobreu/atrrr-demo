# https://jbgruber.github.io/atrrr/

# Setup ####
#install.packages("atrrr")

library(readr)
library(dplyr)
library(purrr)
library(atrrr)

# Authentication ####
auth("you_user_name") # insert your user name here (e.g., tmueller.bsky.social)

# Note: You (will) need to login to your Bluesky account and create an "app password"
# You then need to paste the app password into the popup window that appears after running the auth() function

# Import account list ####
accounts <- read_csv2("./data/candidates_btw25_bluesky.csv") # you may have to adjust the path here
glimpse(accounts)

# Collect data ####

## Single account ####

### Profile information ####
user <- get_user_info("goering-eckardt.de")
glimpse(user)

### Posts ####
posts <- get_skeets_authored_by(actor = "goering-eckardt.de",
                                limit = 100, # maximum number of posts to retrieve
                                parse = TRUE) # whether to parse the posts into a data frame

glimpse(posts)


### Followers ####
followers <- get_followers(actor = "goering-eckardt.de",
                           limit = 100) # maximum number of followers to retrieve

glimpse(followers)

### Following ####
following <- get_follows(actor = "goering-eckardt.de",
              limit = 100)

glimpse(following)

## Multiple accounts ####
library(purrr)

### Profile information ####
users <- map_df(accounts$bluesky, 
                ~get_user_info(actor = .x,
                               parse = TRUE))

glimpse(users)

### Posts ####
all_posts <- map_df(accounts$bluesky,
                    ~get_skeets_authored_by(actor = .x,
                                            limit = 100,
                                            parse = TRUE))
glimpse(all_posts)

### Followers ####
all_followers <- map_df(accounts$bluesky,
                        ~get_followers(actor = .x,
                                       limit = 100),
                        .id = "account")

glimpse(all_followers)

### Following ####
all_following <- map_df(accounts$bluesky,
                        ~get_follows(actor = .x,
                                      limit = 100),
                        .id = "account")

glimpse(all_following)