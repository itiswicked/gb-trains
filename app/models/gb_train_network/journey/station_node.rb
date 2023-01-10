# StationNode is a justified abstraction, as the Station class only wants
# the responsibility of managing station specific data and operations, 
# and evantually become a database model.
# The responsiblity here is tracking algorithmic traversal data,
# which does not relate to the Station domain, but to the Journey domain
module GbTrainNetwork
  module Journey
    class StationNode
      class VisitedConnectionError < StandardError
      end

      attr_reader :station, :visited_connections
      def initialize(station)
        @station = station
        @visited_connections = []
      end

      def label_connection_as_visited(other_station_id)
        unless other_station_is_a_connection?(other_station_id)
          raise VisitedConnectionError, "Station with id: #{other_station_id} is not a connection of station #{@station.id}."
        end

        if connection_already_labeled?(other_station_id)
          raise VisitedConnectionError, "Connection with #{other_station_id} for station: #{station.id} already labeled as visited."
        end

        @visited_connections << other_station_id
      end

      def all_connections_visited?
        not_yet_visited_connections.empty?
      end

      def connection_already_labeled?(other_station_id)
        visited_connections.include?(other_station_id)
      end

      def not_yet_visited_connections
        station.connections - visited_connections
      end

      private
      
      def other_station_is_a_connection?(other_station_id)
        station.connections.include?(other_station_id)
      end
    end
  end
end