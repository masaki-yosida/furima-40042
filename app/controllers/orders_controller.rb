class OrdersController < ApplicationController
  def index
    @item = Item.last
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:price, :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number)
  end
end  
