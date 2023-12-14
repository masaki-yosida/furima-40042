class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping  # または has_many, depending on your association
end