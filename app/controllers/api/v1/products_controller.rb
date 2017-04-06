class Api::V1::ProductsController < ApplicationController

  def show
    product = Product.find_by_id(params[:id])
    if product
      render json: product
    else
      head 404
    end
  end

  def create
    product = Product.new(product_params)
    if product.save
      head 201
    else
      head 400
    end
  end


  private

  def product_params
    params.require(:product).permit(:name, :description)
  end
end
