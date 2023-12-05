# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:id])
  end
end
