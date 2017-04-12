class Api::V1::GetCheckpointsForGoodPathController < ApplicationController
  def index
    checkpoints = Checkpoint.get_details_for(params[:checkpoints])
    if checkpoints
      render json: checkpoints
    else
      render json: {
        invalid_addresses: Checkpoint.invalid_addresses(params[:checkpoints]),
        message: "Invalid address(es)"
      }, status: 400
    end
  end
end
