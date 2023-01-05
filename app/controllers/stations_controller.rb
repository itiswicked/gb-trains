class StationsController < ApplicationController
  def index
    stations = GbTrainNetwork::Station.all
    render json: stations
  end
end
