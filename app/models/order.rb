# app/models/order.rb
class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :purchase
  belongs_to :shipping
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  validates :token, presence: true
  validates :price, presence: true
end
