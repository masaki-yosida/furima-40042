class User < ApplicationRecord
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable
     
       validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, uniqueness: true
       validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)/, message: "is invalid. Include both letters and numbers" }
       validates_confirmation_of :password, message: "doesn't match Password"
       validates :nickname, presence: true
       validates :birthday, presence: true
       validates :firstname_kanji, :lirstname_kanji, presence: true, format: { with: /\A[ァ-ヶー－一-龠]+\z/, message: "is invalid. Input full-width characters" }
       validates :firstname_kana, :lastname_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters" }
     end
     
     