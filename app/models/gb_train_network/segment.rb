module GbTrainNetwork
  class Segment
    attr_reader :source_station, :target_station

    def initialize(source_station:, target_station:)
      @source_station = source_station
      @target_station = target_station
    end

    def matches_bidirectionally?(other_source_station, other_target_station)
      matches_directionally?(other_source_station, other_target_station) ||
        (source_station.id == other_target_station.id && target_station.id == other_source_station.id)
    end

    def matches_directionally?(other_source_station, other_target_station)
      source_station.id == other_source_station.id && target_station.id == other_target_station.id
    end
  end
end