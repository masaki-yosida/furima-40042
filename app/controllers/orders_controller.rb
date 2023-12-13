class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
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
  def index
    # ログイン中で、かつ自身が出品していない売却済みの商品の場合
    if current_user && !current_user.items.where(sold: true).exists?
      redirect_to sold_items_path
    else
      # 通常の処理をここに記述
      @orders = current_user.orders
    end
  end
end
