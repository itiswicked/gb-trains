module GbTrainNetwork
  class Segment
    attr_reader :source_station, :target_station

    def initialize(source_station:, target_station:)
      @source_station = source_station
      @target_station = target_station
    end

    def matches_bidirectionally?(other_segment)
      matches_directionally?(other_segment) ||
        (source_station == other_segment.target_station &&
      target_station == other_segment.source_station)
    end

    def matches_directionally?(other_segment)
      source_station == other_segment.source_station &&
        target_station == other_segment.target_station
    end
  end
end