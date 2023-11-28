class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @item = Item.new
  end
  def create
    @item = current_user.items.build(item_params)

    if @item.save
      # Handle successful creation, e.g., redirect to the item's show page
      redirect_to @item, notice: 'Item was successfully created.'
    else
      # Handle validation errors, e.g., re-render the 'new' form
      render 'new'
    end
  end

  # Other methods...

  private

  
  def item_params
    params.require(:item).permit(:image, :item_name, :item_explanation, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :price)
  end
  
end
