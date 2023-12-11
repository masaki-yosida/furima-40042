# app/models/order.rb
class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :purchase
  belongs_to :shipping
  validates :token, presence: true
  validates :price, presence: true
end
