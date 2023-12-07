class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.last
  end

  def create
    @item = Item.find(params[:item_id])
    purchase = Purchase.new(user_id: current_user.id, item: @item)
  
    if purchase.save
      shipping = Shipping.new(shipping_params)
      shipping.purchase = purchase  # Purchase レコードを関連づける
  
      if shipping.save
        # Order モデルを作成する
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
    params.require(:order).permit(:item_id, :other_attributes)  # 必要に応じて他の属性も追加
  end
end
