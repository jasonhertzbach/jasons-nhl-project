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
You will need to install 2 gems
`gem install httparty`
`gem install rspec`

# Getting Started!
to run the application, you need type `ruby` followed by the file name and 3 arguments: `type`, `id`, and `season` into the terminal
* `type` needs to be either 'team' or 'player'
* `id` will be the Id for either team or player
* `season` is the year the season starts and ends in yyyyyyyy format (eg. 202020201)

team example: `ruby application.rb team 4 20202021`
player example: `ruby application.rb player 8476792 20202021`

the Csv file out to your working directory
