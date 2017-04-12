class Api::V1::LotsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] 

  def create
    product = Product.find_by_id(product_id)
    lot = Lot.new(product: product)
    if lot.save
      render json: lot, status: 201
    else
      head 400
    end
  end

  private

    def product_id
      params[:lot][:product_id]
    end
end
