# app/models/order.rb
class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipalities, :building_name, :street_address, :telephone_number, :presence_id, :token 

  validates :token, presence: true
  validates :post_code, presence: true
  validates :prefecture_id, presence: true
  validates :municipalities, presence: true
  validates :street_address, presence: true
  validates :telephone_number, presence: true
  # 郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なことまだ
  # 電話番号は、10桁以上11桁以内の半角数値のみ保存可能なことまだ


  def save
    # 寄付情報を保存し、変数donationに代入する
    purchase= Purchase.create(item_id: item_id, user_id: user_id)
    
    Shipping.create(post_code: post_code,
     prefecture_id: prefecture_id,
     municipalities: municipalities,
     street_address: street_address,
     telephone_number: telephone_number,
     building_name: building_name,
     purchase_id: purchase.id)
  end

end
