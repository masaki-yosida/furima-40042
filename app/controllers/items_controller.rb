class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
  
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      # Print the errors to the console for debugging
      Rails.logger.error(@item.errors.inspect)
  
      # Render the 'new' template with the @item object
      render 'new'
    end
  end
  
  # Other methods...

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_explanation, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :price)
  end
end
