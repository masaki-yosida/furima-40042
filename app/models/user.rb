class User < ApplicationRecord
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
     
       
       validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)/, message: "is invalid. Include both letters and numbers" }
       validates_confirmation_of :password, message: "doesn't match Password"
       validates :nickname, presence: true
       validates :birthday, presence: true
       validates :firstname_kanji, :lirstname_kanji, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters" }
       validates :firstname_kana, :lastname_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters" }
     end
     
     