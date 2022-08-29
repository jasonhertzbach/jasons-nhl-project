require 'rspec/autorun'
require "./services/nhl_service.rb"

describe NhlService do
    before(:each) { @service = NhlService.new}

    context "set_and_validate_inputs" do        
        it "checks valid team vars" do
            expect(@service.set_and_validate_inputs('team', '2', '20202021')).to eq(true)
        end

        it "checks valid player vars" do
            expect(@service.set_and_validate_inputs('player', '8476792', '20202021')).to eq(true)
        end

        it "checks bad type" do
            expect{@service.set_and_validate_inputs('invalid', '2', '20202021')}.to raise_error('Invalid type, please input either team or player' )
        end

        it "checks bad id" do
            expect{@service.set_and_validate_inputs('team', 'x', '20202021')}.to raise_error('Invalid id, must be an integer')
        end

        it "checks bad season" do
            expect{@service.set_and_validate_inputs('team', '2', '202020c21')}.to raise_error('Invalid season, must be an integer')
        end

        it "checks bad season length" do
            expect{@service.set_and_validate_inputs('team', '2', '202020211')}.to raise_error('Malformed date, needs to be in YYYYYYYY')
        end
    end

    context "get_methods" do
        it "creats a team" do
            @service.set_and_validate_inputs('team', '2', '20202021')
            expect(@service.get_team).to be_a(Team)
        end

        it "creats a team" do
            @service.set_and_validate_inputs('player', '8476792', '20202021')
            expect(@service.get_player).to be_a(Player)
        end
    end

end