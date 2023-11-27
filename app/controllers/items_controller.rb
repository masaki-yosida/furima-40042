class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:restricted_action]

  def index
    @items = Item.all
  end

  def restricted_action
  
  end
  def new
    @item = Item.new
    # 他に必要な初期化などがあればここで行う
  end
end
