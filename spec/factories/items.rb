FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    item_explanation { Faker::Lorem.paragraph }
    association :user
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', 'images', 'example.jpg'),
        'image/jpeg'
      )
    end
    category_id { Faker::Number.between(from: 2, to: 11) }
    situation_id { Faker::Number.between(from: 2, to: 7) }
    postage_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    deliveryday_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Commerce.price(range: 300..1000).to_i }

    # Associate a user with the item
    
  end
end
