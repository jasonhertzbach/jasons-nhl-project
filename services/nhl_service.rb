require 'httparty'
require './models/team.rb'
require './models/player.rb'

class NhlService
    attr_reader :type

    URL = 'https://statsapi.web.nhl.com/api/v1/'

    def initialize
    end

    def get_team
        begin
            set_team_vars(@id, @season)

            team = Team.new
            team.team_id = @parsed_roster['id']
            team.team_name = @parsed_roster['name']
            team.team_venue_name = @parsed_roster['venue']['name']
            team.games_played = @parsed_standings['gamesPlayed']
            team.wins = @parsed_standings['wins']
            team.losses = @parsed_standings['losses']
            team.points = @parsed_standings['pts']
            team.gpg = @parsed_standings['goalsPerGame']
            team.first_game_of_season = @parsed_sched['date']
            team.first_oppo_name = get_first_oppo_name
            team
        rescue => exception
            raise exception.message
        end
    end

    def get_player
        begin
            set_player_vars(@id, @season)

            player = Player.new
            player.player_id = @parsed_player['id']
            player.player_name = @parsed_player['fullName']
            player.current_team = @parsed_player['currentTeam']['name']
            player.player_age = @parsed_player['currentAge']
            player.player_number = @parsed_player['primaryNumber']
            player.player_pos = @parsed_player['primaryPosition']['name']
            player.player_is_rookie = @parsed_player['rookie']
            player.player_assists = @parsed_player_stats['assists']
            player.player_goals = @parsed_player_stats['goals']
            player.player_games = @parsed_player_stats['games']
            player.player_hits = @parsed_player_stats['hits']
            player.player_points = @parsed_player_stats['points']
            player
        rescue => exception
            raise exception.message
        end
    end

    def set_and_validate_inputs(type, id, season)   
        raise 'Invalid type, please input either team or player' unless type == 'team' || type == 'player'
        raise 'Invalid id, must be an integer' unless id.to_i.to_s == id
        raise 'Invalid season, must be an integer' unless season.to_i.to_s == season
        raise 'Malformed date, needs to be in YYYYYYYY' unless season.length == 8
        
        @type = type
        @id = id
        @season = season
        true
    end

    private

    def set_team_vars(id, season)
        team_url = "#{URL}/teams/#{id}"
        options = { query: { season: season, teamId: id} }

        roster = HTTParty.get(team_url + '?expand=team.roster', options)
        @parsed_roster = roster['teams'][0]

        standings = HTTParty.get(team_url + '/stats', options)
        @parsed_standings = standings['stats'][0]['splits'][0]['stat']

        sched = HTTParty.get(URL + 'schedule', options)
        @parsed_sched = sched['dates'][0]
    end

    def get_first_oppo_name
        away = @parsed_sched['games'][0]['teams']['away']['team']['name']
        home = @parsed_sched['games'][0]['teams']['home']['team']['name']

        (home == @parsed_roster['name']) ? away :  home
    end

    def set_player_vars(id, season)
        player_url = "#{URL}/people/#{id}"
        options = { query: { stats: 'statsSingleSeason', season: season} }

        player = HTTParty.get(player_url, options)
        @parsed_player = player['people'][0]

        player_stats = HTTParty.get(player_url + '/stats', options)
        @parsed_player_stats = player_stats['stats'][0]['splits'][0]['stat']
    end
end