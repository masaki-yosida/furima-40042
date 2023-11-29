FactoryBot.define do
  factory :item do
    association :user, factory: :user
    sequence(:item_name) { |n| "Item #{n} - #{Faker::Commerce.product_name}" }
    item_explanation { Faker::Lorem.paragraph }
    category { create(:category) }
    situation { create(:situation) }
    postage { create(:postage) }
    prefecture { create(:prefecture) }
    deliveryday { create(:deliveryday) }

    after(:build) do |item|
      item.image.attach(io: File.open('path/to/your/test/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    end
  end
end
