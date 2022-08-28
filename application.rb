require './services/nhl_service.rb'

type = ARGV[0]
id = ARGV[1]
season = ARGV[2]

service = NhlService.new

if type == 'team'
    result = service.get_team(id, season)
end

if type == 'player'
    result = service.get_player(id, season)
end

CSV.open("results.csv", "w") do |csv|
    values = []
    result.instance_variables.each do |var|
        values << result.instance_variable_get(var)
    end
    csv << values
end