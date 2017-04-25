class Api::V1::GetCheckpointsForGoodPathController < ApplicationController
  def index
    checkpoints = Checkpoint.get_details_for(params[:checkpoints] || [])
    if checkpoints != false
      return render json: checkpoints if checkpoints.any?
      render json: { message: "No addresses sent" }, status: 400
    else
      render json: {
        invalid_addresses: Checkpoint.invalid_addresses(params[:checkpoints]),
        message: "Invalid address(es)"
      }, status: 400
    end
  end
end
