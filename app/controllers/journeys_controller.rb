class JourneysController < ApplicationController
  def create
    puts params

    # JourneyCreator
    render json: {}, status: 400
  end
end
