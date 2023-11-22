require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      user = User.new(nickname: 'test', email: '', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example', password: '', password_confirmation: '')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'birthdayが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: '', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("Birthday can't be blank")
    end
    it 'firstname_kanjiが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', birthday: '1990-01-01', firstname_kanji: '')
      user.valid?
      expect(user.errors.full_messages).to include("Firstname kanji can't be blank")
    end
    it 'lirstname_kanjiが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', birthday: '1990-01-01', firstname_kanji: '田中', lirstname_kanji: '')
      user.valid?
      expect(user.errors.full_messages).to include("Lirstname kanji can't be blank")
    end
    it 'firstname_kanaが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', birthday: '1990-01-01', firstname_kanji: '田中', lirstname_kanji: '家', firstname_kana: '')
      user.valid?
      expect(user.errors.full_messages).to include("Firstname kana can't be blank")
    end
    it 'lastname_kanaが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', birthday: '1990-01-01', firstname_kanji: '田中', lirstname_kanji: '家', firstname_kana: 'カナ', lastname_kana: '')
      user.valid?
      expect(user.errors.full_messages).to include("Lastname kana can't be blank")
    end
    it 'emailが@を含まない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'testexample.com', password: 'password', password_confirmation: 'password', birthday: '1990-01-01', firstname_kanji: '田中', lirstname_kanji: '家', firstname_kana: 'カナ', lastname_kana: 'ミョウジ')
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードが6文字以上であれば登録できる' do
      user = User.new(
        nickname: 'test',
        email: 'test@example.com',
        password: 'Abcd12', # 6文字のパスワード
        password_confirmation: 'Abcd12',
        birthday: '1990-01-01',
        firstname_kanji: '田中',
        lirstname_kanji: '家',
        firstname_kana: 'カナ',
        lastname_kana: 'ミョウジ'
      )
      expect(user).to be_valid
    end
    it 'パスワードとパスワード（確認）が一致していれば登録できる' do
      user = User.new(
        nickname: 'test',
        email: 'test@example.com',
        password: 'Abcd1234',
        password_confirmation: 'Abcd1234',
        birthday: '1990-01-01',
        firstname_kanji: '田中',
        lirstname_kanji: '家',
        firstname_kana: 'カナ',
        lastname_kana: 'ミョウジ'
      )
      expect(user).to be_valid
    end

  end
end


