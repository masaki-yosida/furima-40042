class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
 
  def index
    @item = Item.last
  end
  def create
    @order = Order.new(order_params)
    @item = Item.find(params[:order][:item_id])

    purchase = Purchase.new(user_id: current_user.id, item_id: params[:item_id])
    shipping = Shipping.new(shipping_params)
  
    logger.info("Purchase: #{purchase.inspect}")
    logger.info("Shipping : #{shipping.inspect}")
  
    if purchase.save && shipping_address.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      render :index
      logger.error("Purchase Errors: #{purchase.errors.full_messages}")
  logger.error("Shipping Address Errors: #{shipping_address.errors.full_messages}")
    end
  end
  

  private

  def shipping_params
    params.require(:shipping_address).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number)
  end
end
