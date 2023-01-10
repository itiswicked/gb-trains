RSpec.describe GbTrainNetwork::Journey::Planner do
  it 'takes a starting station and ending station as arguments and find a journey plan between the two' do
    planner = described_class.new(
      source_station: station(1), 
      target_station: station(14), 
      network: stations
    )
    stations_on_path = planner.journey # returns an array of stations representing a pathway from start to ending
    pp stations_on_path
  end
end

def stations
  @_stations ||= GbTrainNetwork::Station.all
end

def station(id)
  stations.find { |station| station.id === id }
end