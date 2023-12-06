class OrdersController < ApplicationController
  def index
    @item = Item.last
  end
end
