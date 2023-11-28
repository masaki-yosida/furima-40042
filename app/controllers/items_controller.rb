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
    @item = Item.new
  end

  # 他のアクションも追加
  # 例: show, edit, create, update, destroyなど

  private

  # 必要に応じてプライベートメソッドを追加
end
