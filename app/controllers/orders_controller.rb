class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id] || params[:id])
  
    if user_signed_in? && current_user == @item.user
      redirect_to root_path, alert: '自分が出品した商品の購入ページにはアクセスできません'
      return
    end
  
    if @item.sold_out?
      redirect_to root_path, alert: 'この商品は売り切れています'
      return
    end
  
    @purchase_shipping = PurchaseShipping.new
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
    end

  def index
    @item = Item.find(params[:item_id] || params[:id])
  
    if user_signed_in?
      if current_user == @item.user
        redirect_to root_path, alert: '自分が出品した商品の購入ページにはアクセスできません'
        return
      end
    else
      redirect_to new_user_session_path, alert: 'ログインしてください'
      return
    end
  
    if @item.sold_out?
      redirect_to root_path, alert: 'この商品は売り切れています'
      return
    end
  
    @purchase_shipping = PurchaseShipping.new
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
