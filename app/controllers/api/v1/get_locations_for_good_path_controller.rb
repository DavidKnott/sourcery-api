class Api::V1::GetLocationsForGoodPathController < ApplicationController

  def index
    locations = Location.get_details_for(params[:locations])
    render json: locations
  end
end