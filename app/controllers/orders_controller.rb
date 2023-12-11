class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @orders = current_user.orders.includes(:items)  # Fetch orders associated with the current user
  end

  def create
    @item = Item.find(params[:item_id])
    purchase = Purchase.new(user_id: current_user.id, item: @item)

    if purchase.save
      shipping = Shipping.new(shipping_params)
      shipping.purchase = purchase

      if shipping.save
        pay_item
        @order = Order.create(purchase: purchase, shipping: shipping)
        redirect_to root_path, notice: '購入が完了しました。'
      else
        render :index
        logger.error("Shipping Address Errors: #{shipping.errors.full_messages}")
      end
    else
      render :index
      logger.error("Purchase Errors: #{purchase.errors.full_messages}")
    end
  end

  private

  def shipping_params
    params.require(:shipping_address).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number)
  end

  def order_params
    params.permit(:item_id, :other_attributes)  # Modify this based on your actual form structure
  end

  def pay_item
    Payjp.api_key = "sk_test_20f0b00a57fc65033f27b598"
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
