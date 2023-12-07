# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :purchase
  belongs_to :shipping
end
