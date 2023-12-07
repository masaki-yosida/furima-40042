class OrdersController < ApplicationController
  def index
    @item = Item.last
    if @item.nil?
      # @item が存在しない場合のエラー処理などを追加
      redirect_to root_path, alert: 'No item found.'
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_form = PurchaseForm.new(purchase_params)

    if @purchase_form.save
      # 保存成功時の処理（例: リダイレクトやメッセージ表示）
      redirect_to root_path, notice: '購入が完了しました。'
    else
      # 保存失敗時の処理（例: エラーメッセージ表示や再描画）
      Rails.logger.error(@purchase_form.errors.full_messages)
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:hoge, :fuga, ...other_attributes)
  end
end
