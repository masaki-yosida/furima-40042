# app/models/order.rb
class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :purchase
  belongs_to :shipping
  validates :token, presence: true
  validates :price, presence: true
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
end
