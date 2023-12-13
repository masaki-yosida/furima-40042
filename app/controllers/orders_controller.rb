class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping = PurchaseShipping.new
    if user_signed_in? && current_user != @item.user
      if @item.sold_out?
        redirect_to root_path, alert: 'この商品は売り切れています'
        return
      end
    end
  end
  

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if 
      @purchase_shipping.valid?
      @purchase_shipping.save
      pay_item
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping).permit(:item_id, :post_code, :prefecture_id, :municipalities, :building_name, :street_address, :building_name, :telephone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
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
