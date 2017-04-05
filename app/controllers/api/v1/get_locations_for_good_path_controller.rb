class Api::V1::GetLocationsForGoodPathController < ApplicationController

  def index
    locations = Location.get_details_for(params[:locations])
    if locations
      render json: locations
    else
      head 404
    end
  end
end