# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :item  # 注文は商品に関連していると仮定

  validates :price, presence: true  # 価格が存在することを検証

  # その他の属性やメソッドを追加できます
end
