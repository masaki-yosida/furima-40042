class User < ApplicationRecord
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
     

       validates :nickname, :birthday, presence: true
       has_many :items
       has_many :purchases

       validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/, message: "must contain at least one letter and one number" }
       validates_confirmation_of :password, message: "doesn't match Password"
     

       validates :firstname_kanji, :lirstname_kanji, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters" }
       validates :firstname_kana, :lastname_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters" }
     
       validates_format_of :firstname_kanji, :lirstname_kanji, with: /\A[^ -~｡-ﾟ]+\z/, message: "is invalid. Input full-width characters"
       validates_format_of :firstname_kana, :lastname_kana, with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters"
     end
     