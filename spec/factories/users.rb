# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.characters }
    email { Faker::Internet.email }
    password { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    firstname_kanji { '山田' }
    lirstname_kanji { '太郎' }
    firstname_kana { 'ヤマダ' }
    lastname_kana { 'タロウ' }
    birthday { Faker::Date.birthday.to_s }
  end
end
