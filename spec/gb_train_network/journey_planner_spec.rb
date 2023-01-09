RSpec.describe GbTrainNetwork::JourneyPlanner do

  it 'takes a starting station and ending station as arguments and find a journey plan between the two' do
    stations = GbTrainNetwork::Station.all
    source_station = stations.find { |station| station.id === 1 }
    target_station = stations.find { |station| station.id === 8 }
    planner = described_class.new(
      source_station: source_station, 
      target_station: target_station, 
      network: stations
    )
    stations_on_path = planner.journey # returns an array of stations representing a pathway from start to ending

    require 'pry';binding.pry
  end
  
end