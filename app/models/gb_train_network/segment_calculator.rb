module GbTrainNetwork
  class SegmentCalculator
    def initialize(stations)
      @stations = stations
      @segments ||= []
    end

    # segments needs a station passed to it somehow in order to be recursive
    def segments
      return @segments if !@segments.empty?
      
      get_segments_from_station(@stations.first)

      @segments
    end

    def get_segments_from_station(starting_station)
      connected_segments = starting_station.connections.map do |connection| 
        Segment.new(source_station: starting_station.id, target_station: connection)
      end

      # I.e. recurse break state is when all neighbor nodes have been visited
      return if all_segments_accounted_for?(connected_segments)

      # add the relevant segments
      connected_segments.each do |segment|
        if segment_not_accounted_for?(segment)
          @segments << segment
          next_station_to_visit = @stations.find { |station| station.id == segment.target_station }
          
          if next_station_to_visit.nil?
            raise "Station with id: #{segment.target_station} not found!"
          end
          
          # require 'pry';binding.pry if next_station_to_visit.nil?
          get_segments_from_station(next_station_to_visit)
        end
      end
    end

    def segment_not_accounted_for?(segment_to_check)
      @segments.none? { |segment| segment.matches_bidirectionally?(segment_to_check) }
    end

    def all_segments_accounted_for?(segments_to_account_for)
      segments_to_account_for.all? do |segment_to_account_for|
        @segments.find { |segment| segment.matches_bidirectionally?(segment_to_account_for) }
      end
    end
  end
end