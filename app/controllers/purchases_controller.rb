# app/controllers/purchases_controller.rb

class PurchasesController < ApplicationController
  def new
    @purchase_form = PurchaseForm.new
  end

  def create
    puts "Params: #{params.inspect}"
    @purchase_form = PurchaseForm.new(purchase_params)
  
    if @purchase_form.save
      # 保存が成功した場合の処理
      redirect_to success_path, notice: 'Purchase successful!'
    else
      # 保存が失敗した場合の処理
      render :new
    end
  end
  

  private

  def purchase_params
    params.require(:purchase_form).permit(
      :credit_card_number,
      :expiration_date,
      :security_code,
      shipping_address_attributes: [
        :post_code,
        :prefecture_id,
        :municipalities,
        :street_address,
        :building_name,
        :telephone_number
      ]
    )
  end
  
end

