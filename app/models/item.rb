class Item < ApplicationRecord
  belongs_to :user
  validates :item_name, :item_explanation, :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, :price, presence: true
  has_one_attached:image
end