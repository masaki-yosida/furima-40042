FactoryBot.define do
  factory :purchase_shipping do
    association :user
    association :item
    post_code { '123-4567' }
    prefecture_id { 3 }
    municipalities { '横浜市緑区' }
    street_address { '3-4' }
    building_name { '青山ビル' }
    telephone_number { '09012341234' }
    token {"tok_abcdefghijk00000000000000000"}
   
  end
end