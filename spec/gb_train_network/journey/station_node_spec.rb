RSpec.describe GbTrainNetwork::Journey::StationNode do
  describe "#label_connection_as_visited" do
    it "labels a connection as visited" do
      station = station(1)
      visited_connection = 5
      node = described_class.new(station)
      node.label_connection_as_visited(visited_connection)

      expect(node.visited_connections).to include(visited_connection)
    end

    it "complains when a connection to be labeled is NOT a connection of the original station" do
      station = station(1)
      node = described_class.new(station)

      expect { node.label_connection_as_visited(1000) }
        .to raise_error(GbTrainNetwork::Journey::StationNode::VisitedConnectionError)
    end
  end

  describe "#all_connections_visited?" do
    it "returns true if visited connections is the same as all connections for the station" do
      station = station(1)
      node = described_class.new(station)
      station.connections.each { |conn| node.label_connection_as_visited(conn) }

      expect(node.all_connections_visited?).to eq(true)
    end

    it "returns false if visited connections does not contain the same connections as the station" do
      station = station(1)
      visited_connection = 5
      node = described_class.new(station)
      node.label_connection_as_visited(visited_connection)

      expect(node.all_connections_visited?).to eq(false)
    end
  end

  describe "#not_yet_visited_connections" do
    it "returns a list of connections not yet labeled as visited" do
      station = station(1)
      visited_connection = 5
      node = described_class.new(station)
      node.label_connection_as_visited(visited_connection)

      expect(node.not_yet_visited_connections).to eq([9, 3, 4])
    end
  end
end

def stations
  @_stations ||= GbTrainNetwork::Station.all
end

def station(id)
  stations.find { |station| station.id === id }
end