require './application'

# Player Pipeline - Provide a player id and season year which outputs a CSV file. The CSV should include the following:
@player_id = '8476792' #@player
@season = '20212022' #@seasons
@player_url = "#{URL}/people/#{@player_id}"

@options = { query: { season: @season} }

player = HTTParty.get(@player_url, @options)
parsed_player = player['people'][0]

player_id = parsed_player['id']
player_name = parsed_player['fullName']
current_team = parsed_player['currentTeam']['name']
player_age = parsed_player['currentAge']
player_number = parsed_player['primaryNumber']
player_pos = parsed_player['primaryPosition']['name']
player_is_rookie = parsed_player['rookie']

@options = { query: { stats: 'statsSingleSeason', season: @season} }

player_stats = HTTParty.get(@player_url + '/stats', @options)
parsed_player_stats = player_stats['stats'][0]['splits'][0]['stat']

player_assists = parsed_player_stats['assists']
player_goals = parsed_player_stats['goals']
player_games = parsed_player_stats['games']
player_hits = parsed_player_stats['hits']
player_points = parsed_player_stats['points']


p player_id
p player_name
p current_team
p player_age
p player_number
p player_pos
p player_is_rookie
p player_assists
p player_goals
p player_games
p player_hits
p player_points
