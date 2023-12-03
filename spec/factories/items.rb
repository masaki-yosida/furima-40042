FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    item_explanation { Faker::Lorem.paragraph }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'example.jpg'), 'image/jpeg') }
    category_id { Faker::Number.between(from: 2, to: 11) }
    situation_id { Faker::Number.between(from: 2, to: 7) }
    postage_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    deliveryday_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Commerce.price(range: 100..10000) }

    # Add other attributes as needed
  end
end
