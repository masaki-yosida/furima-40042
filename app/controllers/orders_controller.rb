class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]


  def new
  end

  def index
    redirect_if_item_owner
    @purchase_shipping = PurchaseShipping.new
  
    if @item.sold_out?
      redirect_to_sold_out
      return  # アクションの実行を終了する
    end
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
      @purchase_shipping.save
      pay_item
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id] || params[:id])
  end

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

  def redirect_if_item_owner
    if user_signed_in? && current_user == @item.user
      redirect_to root_path, alert: '自分が出品した商品の購入ページにはアクセスできません'
      return  # アクションの実行を終了する
    end
  end

  def redirect_to_sold_out
    redirect_to root_path, alert: 'この商品は売り切れています'
  end
end
