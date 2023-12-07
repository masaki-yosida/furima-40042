# app/models/purchase.rb

class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address
  accepts_nested_attributes_for :shipping_address
end
