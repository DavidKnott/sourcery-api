class Api::V1::CheckpointsController < ApplicationController

  def show
    checkpoint = Checkpoint.find_by(ethereum_address: params[:id])
    if checkpoint
      render json: checkpoint
    else
      head 404
    end
  end

  def create
    checkpoint = Checkpoint.new(checkpoint_params)
    if checkpoint.save
      head 201
    else
      head 400
    end
  end

  private

  def checkpoint_params
    params.require(:checkpoint).permit(
      :creator, :street_address, :city, 
      :state, :country, :ethereum_address, 
      :lat, :lng, :zipcode
    )
  end
end
