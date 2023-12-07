# app/models/purchase_form.rb

class PurchaseForm
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :city, :addresses, :building, :phone_number

  

  validates :item_id, :user_id, :post_code, :prefecture, :city, :addresses, :phone_number, presence: true
  # その他のバリデーションルールを追加

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      purchase = Purchase.create!(item_id: item_id, user_id: user_id)
      ShippingAddress.create!(
        post_code: post_code,
        prefecture: prefecture,
        city: city,
        addresses: addresses,
        building: building,
        phone_number: phone_number,
        purchase_id: purchase.id
      )
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end
end
