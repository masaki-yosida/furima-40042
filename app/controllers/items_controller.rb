class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
  end
def create
  @item = current_user.items.build(item_params)

  if @item.save
    redirect_to root_path, notice: 'Item was successfully created.'
  else
    render :new, status: :unprocessable_entity
    @categories = Category.all  # カテゴリーなどの選択肢を再度取得
    @situations = Situation.all
    @postages = Postage.all
    @prefectures = Prefecture.all
    @deliverydays = Deliveryday.all
  end
end
def index
  @items = Item.all
end
def edit
  @item = Item.find(params[:id])
end
def show
  @item = Item.find(params[:id])
end


def update
  @item = Item.find(params[:id])
  if @item.update(item_params)
    redirect_to @item, notice: '商品が更新されました。'
  else
    render :edit
  end
end



  # Other methods...

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_explanation, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :price)
  end
end
