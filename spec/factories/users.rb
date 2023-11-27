# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.characters }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    firstname_kanji { Faker::Name.first_name }
    lirstname_kanji { Faker::Name.last_name }
    firstname_kana { Faker::Name.first_name }
    lastname_kana { Faker::Name.last_name }
    birthday { Faker::Date.birthday.to_s }
  end
end
