class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :redirect_if_not_item_owner, only: [:edit, :destroy]
 



  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
      load_select_options
    end
  end

  def index
    @items = Item.all
  end

  def edit
    redirect_if_not_item_owner
  end

  def show
    
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: '商品が削除されました。'
  end

  def update
    redirect_if_not_item_owner

    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_explanation, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :price)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def load_select_options
    @categories = Category.all
    @situations = Situation.all
    @postages = Postage.all
    @prefectures = Prefecture.all
    @deliverydays = Deliveryday.all
  end

  def redirect_if_not_item_owner
    return if user_signed_in? && current_user == @item.user
  
    if @item.sold_out?
      redirect_to root_path, alert: 'この商品は売り切れています'
    else
      # 商品の出品者でない場合、直接ビューを表示
      render file: 'app/views/orders/index.html.erb', status: :ok
    end
  end
  
  
  
end
