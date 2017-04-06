class Api::V1::LocationsController < ApplicationController

  def show
    location = Location.find_by(ethereum_address: params[:id])
    if location
      render json: location
    else
      head 404
    end
  end

  def create
    location = Location.new(location_params)
    if location.save
      head 201
    else
      head 400
    end
  end

  private

  def location_params
    params.require(:location).permit(
      :creator, :street_address, :city, 
      :state, :country, :ethereum_address, 
      :lat, :lng, :zipcode
    )
  end
end
