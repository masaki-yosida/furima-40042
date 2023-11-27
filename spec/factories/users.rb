# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    nickname              { Faker::Lorem.characters(number: 1) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    firstname_kanji       { Faker::Japanese::Name.first_name.gsub(/[^一-龯]/, '') }
    listname_kanji        { Faker::Japanese::Name.list_name.gsub(/[^一-龯]/, '') }
    firstname_kana        { Faker::Japanese::Name.first_name.yomi.tr("ぁ-ん", "ァ-ン") }
    lastname_kana         { Faker::Japanese::Name.last_name.yomi.tr("ぁ-ん", "ァ-ン") }
    birthday              { Faker::Date.birthday.to_s }
  end
end
