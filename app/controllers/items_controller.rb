class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:restricted_action]

  def index
    @items = Item.all
  end

  def restricted_action
    # restricted_action のコードを追加
    # 例: 特定の処理を実行するなど
  end

  def new
    @user = current_user # Assign the current user or fetch it in some way
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      flash.now[:alert] = 'Failed to create the item.'
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_explanation, :price, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :user_id)
  end

  # 必要に応じてプライベートメソッドを追加
end
