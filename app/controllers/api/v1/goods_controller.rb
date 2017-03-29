class Api::V1::GoodsController < ApplicationController

  def create
    good = Good.new(good_params)
    if good.save
      head 201
    end
  end


  private

  def good_params
    params.require(:good).permit(:name, :description)
  end
end