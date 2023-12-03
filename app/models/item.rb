class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :situation
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :deliveryday

  validates :image, :item_name, :item_explanation, presence: true
  validates :category_id, :situation_id, :postage_id, :prefecture_id, :deliveryday_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  has_one_attached :image
end
