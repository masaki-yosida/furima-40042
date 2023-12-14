# app/models/purchase_shipping
class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipalities, :building_name, :street_address, :telephone_number, :presence_id, :token 
  
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁ハイフン4桁」の形式で入力してください" }
    validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :municipalities
    validates :street_address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数値で入力してください" }
  end

  def save
    purchase= Purchase.create(item_id: item_id, user_id: user_id)
    
    Shipping.create(post_code: post_code,
     prefecture_id: prefecture_id,
     municipalities: municipalities,
     street_address: street_address,
     telephone_number: telephone_number,
     building_name: building_name,
     purchase_id: purchase.id)
  end
  def user=(user)
    @user = user
  end
  def item=(item)
    @item = item
  end

end
