FactoryBot.define do
  factory :shipping do
    post_code { Faker::Lorem.characters }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipalities { '1a' + Faker::Internet.password(min_length: 4) }
    street_address { password }
    telephone_number { '山田' }
  end
end
