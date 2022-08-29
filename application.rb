require './services/nhl_service.rb'

service = NhlService.new
service.set_and_validate_inputs(ARGV[0], ARGV[1], ARGV[2])

if service.type == 'team'
    result = service.get_team
end

if service.type == 'player'
    result = service.get_player
end

if result
    CSV.open("#{service.type}_results.csv", "w") do |csv|
        values = []
        result.instance_variables.each do |var|
            values << result.instance_variable_get(var)
        end
        csv << values
    end
    p "open #{service.type}_results.csv for result :)"
end