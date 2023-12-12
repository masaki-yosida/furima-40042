class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :deliveryday
  belongs_to :user
  has_one  :shipping
  has_many :purchases

  def sold_out?
    # 在庫管理などの条件に基づいて売り切れているかどうかを判断するロジックを実装する
    # 例えば、在庫が0の場合に売り切れとするなど
    # 以下は単純な例です
    purchases.present?
  end




  
  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_explanation, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :situation_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :postage_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :deliveryday_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  has_one_attached:image
  
end