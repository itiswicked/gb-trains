class MapController < ApplicationController
  def index
    nodes = stations = GbTrainNetwork::Station.all

    links = [
      { source: 1, target: 2 },
      { source: 2, target: 3 }
    ]
    render json: { nodes: nodes, links: links }
  end
end
