RSpec.describe GbTrainNetwork::Helpers do

  describe ".calculate_station_distance" do
    it "raises an error unless the stations are adjacent" do
      # TODO: install rspec-mocks and use verifying doubles
      station_1 = GbTrainNetwork::Station.new(1, "1", {}, [5, 4])
      station_2 = GbTrainNetwork::Station.new(2, "2", {}, [3, 4])

      expect { 
        described_class.calculate_station_distance(station_1, station_2) 
      }.to raise_error GbTrainNetwork::UnconnectedStationError
    end
    
    it "is Pythagorean's theorum" do
      station_1 = GbTrainNetwork::Station.new(1, "1", {"x" => 0, "y" => 0}, [2])
      station_2 = GbTrainNetwork::Station.new(2, "2", {"x" => 1, "y" => 1}, [1])

      expect( 
        described_class.calculate_station_distance(station_1, station_2).round(3)
      ).to eq(1.414)

      station_3 = GbTrainNetwork::Station.new(1, "1", {"x" => 5, "y" => 7}, [2])
      station_4 = GbTrainNetwork::Station.new(2, "2", {"x" => 0, "y" => 0}, [1])

      expect( 
        described_class.calculate_station_distance(station_3, station_4).round(3)
      ).to eq(8.602)
    end
  end
end