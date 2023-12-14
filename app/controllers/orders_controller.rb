class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
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

  def new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
      @purchase_shipping.save
      pay_item
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
  

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_shipping).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
