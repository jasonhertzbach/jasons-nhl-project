# Welcome to my NHL stats application!

This application will output a CSV file with the following information for either a team or player!

* **Teams** 
  * Team ID
  * Team Name
  * Team Venue Name
  * Games Played
  * Wins
  * Losses
  * Points
  * Goals Per Game
  * Game Date of First Game of Season
  * Opponent Name in First Game of Season

* **Players** 
  * Player ID
  * Player Name
  * Current Team
  * Player Age
  * Player Number
  * Player Position
  * If the player is a rookie
  * Assists
  * Goals
  * Games
  * Hits
  * Points

# Before getting started
This guide is assuming that you have ruby installed, I am using v3.0.0. Older versions should work as well. If you do not have Ruby installed, you can use this page to install it https://www.ruby-lang.org/en/documentation/installation/

You will need to install 2 gems.
To install them run the following commands:
* `gem install httparty`
* `gem install rspec`

# Getting Started!
To run the application, you need type `ruby` followed by the file name and 3 arguments: `type`, `id`, and `season` into the terminal.
* `type` needs to be either 'team' or 'player'
* `id` will be the Id for either team or player
* `season` is the year the season starts and ends in yyyyyyyy format (eg. 202020201)

team example: `ruby application.rb team 4 20202021`
player example: `ruby application.rb player 8476792 20202021`

The CSV file will output to your working directory, named `type`_results.csv

# Running tests
To run the tests, use the command `ruby test_application.rb`