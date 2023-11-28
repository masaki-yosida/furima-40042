# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:new, :create]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = @user.items.build
  end

  def create
    @item = @user.items.build(item_params)

    if @item.save
      redirect_to user_item_path(@user, @item), notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to user_item_path(@user, @item), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to user_items_path(@user), notice: 'Item was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_item
    @item = @user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description)
  end
end

