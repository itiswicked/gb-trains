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
      connected_segments = starting_station.connections.map do |connection_id| 
        target_station = @stations.find { |station| station.id == connection_id }
        Segment.new(source_station: starting_station, target_station: target_station)
      end

      # I.e. recurse break state is when all neighbor nodes have been visited
      return if all_segments_accounted_for?(connected_segments)

      # add the relevant segments
      connected_segments.each do |segment|
        if segment_not_accounted_for?(segment)
          @segments << segment
          next_station_to_visit = segment.target_station
          
          get_segments_from_station(next_station_to_visit)
        end
      end
    end

    private

    def segment_not_accounted_for?(segment_to_check)
      @segments.none? do |segment| 
        segment.matches_bidirectionally?(segment_to_check.source_station, segment_to_check.target_station)
      end
    end

    def all_segments_accounted_for?(segments_to_check)
      segments_to_check.all? do |segment_to_check|
        @segments.find do |segment| 
          segment.matches_bidirectionally?(segment_to_check.source_station, segment_to_check.target_station)
        end
      end
    end
  end
end