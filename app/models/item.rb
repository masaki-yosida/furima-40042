
class Item < ApplicationRecord
  # Ensure that the attribute names match the columns in the database
  validates :item_name, presence: true
  validates :item_explanation, presence: true
  

  has_one_attached :image

  # ... other validations and associations

end


