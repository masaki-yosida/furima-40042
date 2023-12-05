# app/controllers/purchases_controller.rb
class PurchasesController < ApplicationController
  def new
    # 購入画面の表示ロジックを追加
  end

  def create
    # 購入処理の実装
    
    # 購入処理成功後にリダイレクト
    redirect_to orders_path, notice: '購入が完了しました。'
  end
end
