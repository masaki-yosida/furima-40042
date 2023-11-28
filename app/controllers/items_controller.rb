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

  def create
    # フォームからのデータを使って新しいアイテムを作成
    @item = Item.new(item_params)

    # 保存が成功した場合と失敗した場合で処理を分岐
    if @item.save
      # 保存に成功した場合の処理
      redirect_to @item, notice: 'アイテムが正常に作成されました。'
    else
      # 保存に失敗した場合の処理
      render :new
    end
  end

  private

  def item_params
    # フォームから受け取るパラメータを指定
    params.require(:item).permit(:name, :description, :category, :other_attribute) # 実際のカラム名に置き換える
  end
end
