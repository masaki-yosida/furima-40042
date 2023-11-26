class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:restricted_action]

  def index
    @items = Item.all
  end

  def restricted_action
  
  end
end
