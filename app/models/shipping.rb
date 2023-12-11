# app/models/shipping.rb
class Shipping < ApplicationRecord
  belongs_to :purchase
  validates :post_code, :prefecture_id, :municipalities, :street_address, :telephone_number, presence: true
 

end
