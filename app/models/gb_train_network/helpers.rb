# I hate this but this is the best way right now
module GbTrainNetwork
  class UnconnectedStationError < StandardError
  end

  class Helpers
    def self.calculate_station_distance(station_a, station_b)
      unless station_a.connection_exists?(station_b.id) && station_b.connection_exists?(station_a.id)
        raise UnconnectedStationError, "Distance between stations cannot be determined, as they are not adjacent."
      end

      x_distance_squared = (station_b.coordinates["x"] - station_a.coordinates["x"]) ** 2
      y_distance_squared = (station_b.coordinates["y"] - station_a.coordinates["y"]) ** 2

      Math.sqrt(x_distance_squared + y_distance_squared)
    end
  end
end
    