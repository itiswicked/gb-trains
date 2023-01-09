module GbTrainNetwork
  class Station
    class DuplicateConnectionError < StandardError
    end

    def self.all
      file_path = "#{File.expand_path(File.dirname(__FILE__))}/stations.json"
      station_data = JSON.load(File.read(file_path))

      stations_from_data(station_data["stations"])
    end


      def self.stations_from_data(station_data)
        station_data.map do |station_datum|
          # Refactor to swallow all data as one arg
          station = Station.new(station_datum["id"], station_datum["name"], station_datum["coordinates"])
          add_conntections_to_station(station, station_datum["connections"])

          station
        end
      end

      # Refactor. Accept connection through init of Station
      def self.add_conntections_to_station(station, connections_datum)
        connections_datum.each do |connecting_station|
          station.add_connection(connecting_station)
        end
      end

    attr_reader :connections, :name, :id

    def initialize(id, name, coordinates, connections = [])
      @id = id
      @name = name
      @coordinates = coordinates
      @connections = connections
    end

    def add_connection(connecting_station)
      if connection_exists?(connecting_station)
        raise DuplicateConnectionError, "Station #{name} already contains a connection for #{connecting_station.name}"
      end

      connections << connecting_station
    end

    def connection_exists?(station)
      connections.include?(station)
    end
  end
end