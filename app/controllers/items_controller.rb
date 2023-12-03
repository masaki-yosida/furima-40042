class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
    @categories = Category.all
    @situations = Situation.all
    @postages = Postage.all
    @prefectures = Prefecture.all
    @deliverydays = Deliveryday.all
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.'
    else
      # If the save fails, populate the instance variables for the form
      @categories = Category.all
      @situations = Situation.all
      @postages = Postage.all
      @prefectures = Prefecture.all
      @deliverydays = Deliveryday.all

      render :new, status: :unprocessable_entity
    end
  end

  # Other methods...

  private

  def item_params
    params.require(:item).permit(:item_name, :item_explanation, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :price, :image)
  end
end
