require './application'

# (WIP NEED TO GET A LIST OF TEAM IDS)
@team_id = @team #1
@season = @seasons #'20212022'

@team_url = "#{URL}/teams/#{@team_id}"
@options = { query: { season: @season} }

roster = HTTParty.get(@team_url + '?expand=team.roster', @options)
parsed_roster = roster['teams'][0]

standings = HTTParty.get(@team_url + '/stats', @options)
parsed_standings = standings['stats'][0]['splits'][0]['stat']

team_id = parsed_roster['id']
team_name = parsed_roster['name']
team__venue_name = parsed_roster['venue']['name']

games_played = parsed_standings['gamesPlayed']
wins = parsed_standings['wins']
losses = parsed_standings['losses']
points = parsed_standings['pts']
gpg = parsed_standings['goalsPerGame']


@options = { query: { season: @season, teamId: @team_id} }
sched = HTTParty.get(URL + 'schedule', @options)

# Opponent Name in First Game of Season
away = sched['dates'][0]['games'][0]['teams']['away']['team']['name']
home = sched['dates'][0]['games'][0]['teams']['home']['team']['name']

first_game_of_season = sched['dates'][0]['date']
first_oppo_name = (home == roster['teams'][0]['name']) ? away :  home

p team_id
p team_name
p team__venue_name
p games_played
p wins
p losses
p points
p gpg
p first_game_of_season
p first_oppo_name