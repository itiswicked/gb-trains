class MapController < ApplicationController
  def index
    stations = stations = GbTrainNetwork::Station.all
    segments = GbTrainNetwork::SegmentCalculator.new(stations).segments
# require 'pry';binding.pry
    render json: { stations: stations, segments: segments }
  end
end
