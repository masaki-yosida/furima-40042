class Item < ApplicationRecord
  belongs_to :user

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_explanation, presence: true
  validates :category_id, presence: true
  validates :situation_id, presence: true
  validates :postage_id, presence: true
  validates :prefecture_id, presence: true
  validates :deliveryday_id, presence: true
  validates :price, presence: true

  has_one_attached :image
end
