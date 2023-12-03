class Item < ApplicationRecord
  belongs_to :category, class_name: 'Category'
  belongs_to :user
  belongs_to :situation
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :deliveryday

  validates :item_name, presence: true
  validates :item_explanation, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :situation_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :deliveryday_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :image, presence: true

  has_one_attached :image
end
