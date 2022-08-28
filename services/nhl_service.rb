require 'httparty'
require './models/team.rb'
require './models/player.rb'

class NhlService

    URL = 'https://statsapi.web.nhl.com/api/v1/'

    def initialize
    end

    def get_team(team_id = '1', season = '20212022')

        team_url = "#{URL}/teams/#{team_id}"
        options = { query: { season: season} }

        roster = HTTParty.get(team_url + '?expand=team.roster', options)
        parsed_roster = roster['teams'][0]

        standings = HTTParty.get(team_url + '/stats', options)
        parsed_standings = standings['stats'][0]['splits'][0]['stat']

        options = { query: { season: season, teamId: team_id} }
        sched = HTTParty.get(URL + 'schedule', options)

        away = sched['dates'][0]['games'][0]['teams']['away']['team']['name']
        home = sched['dates'][0]['games'][0]['teams']['home']['team']['name']

        team = Team.new
        team.team_id = parsed_roster['id']
        team.team_name = parsed_roster['name']
        team.team_venue_name = parsed_roster['venue']['name']
        team.games_played = parsed_standings['gamesPlayed']
        team.wins = parsed_standings['wins']
        team.losses = parsed_standings['losses']
        team.points = parsed_standings['pts']
        team.gpg = parsed_standings['goalsPerGame']
        team.first_game_of_season = sched['dates'][0]['date']
        team.first_oppo_name = (home == roster['teams'][0]['name']) ? away :  home
        team
    end

    def get_player(player_id = '8476792', season = '20212022')

        player_url = "#{URL}/people/#{player_id}"
        options = { query: { season: season} }

        player = HTTParty.get(player_url, options)
        parsed_player = player['people'][0]

        options = { query: { stats: 'statsSingleSeason', season: season} }
        player_stats = HTTParty.get(player_url + '/stats', options)
        parsed_player_stats = player_stats['stats'][0]['splits'][0]['stat']

        player = Player.new
        player.player_id = parsed_player['id']
        player.player_name = parsed_player['fullName']
        player.current_team = parsed_player['currentTeam']['name']
        player.player_age = parsed_player['currentAge']
        player.player_number = parsed_player['primaryNumber']
        player.player_pos = parsed_player['primaryPosition']['name']
        player.player_is_rookie = parsed_player['rookie']
        player.player_assists = parsed_player_stats['assists']
        player.player_goals = parsed_player_stats['goals']
        player.player_games = parsed_player_stats['games']
        player.player_hits = parsed_player_stats['hits']
        player.player_points = parsed_player_stats['points']
        player
    end

end