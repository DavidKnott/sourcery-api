class Api::V1::GetLocationsForGoodPathController < ApplicationController
  def index
    locations = Location.get_details_for(params[:locations])
    if locations
      render json: locations
    else
      render json: {
        invalid_addresses: Location.invalid_addresses(params[:locations]),
        message: "Invalid address(es)"
      }, status: 400
    end
  end
end
