# spec/models/user_spec.rb
require 'rails_helper'
require 'faker'
FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'password123' }
    firstname_kanji { Faker::Name.first_name }
    listname_kanji { Faker::Name.list_name }
    firstname_kana { 'カナ' }
    lastname_kana { 'カナ' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
RSpec.describe User, type: :model do
  describe '正常系' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての項目が入力されていれば登録できること' do
      expect(@user).to be_valid
    end
  end

  describe '異常系' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'nickname' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = nil
        expect(@user).not_to be_valid
      end
    end

    context 'メールアドレス' do
      it 'メールアドレスが空では登録できないこと' do
        @user.email = nil
        expect(@user).not_to be_valid
      end
    
      it '重複したメールアドレスは登録できないこと' do
        FactoryBot.create(:user, email: @user.email)
        expect(@user).not_to be_valid
      end
    
      it 'メールアドレスに@を含まない場合は登録できないこと' do
        @user.email = 'invalid_email'
        expect(@user).not_to be_valid
      end
    end
    

    context 'パスワード' do
      it 'パスワードが空では登録できないこと' do
        @user.password = nil
        expect(@user).not_to be_valid
      end

      it 'パスワードが6文字未満では登録できないこと' do
        @user.password = 'abc12'
        expect(@user).not_to be_valid
      end

      it '英字のみのパスワードでは登録できないこと' do
        @user.password = 'abcdef'
        expect(@user).not_to be_valid
      end

      it '数字のみのパスワードでは登録できないこと' do
        @user.password = '123456'
        expect(@user).not_to be_valid
      end

      it '全角文字を含むパスワードでは登録できないこと' do
        @user.password = 'あいうえお12'
        expect(@user).not_to be_valid
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できないこと' do
        @user.password_confirmation = 'different_password'
        expect(@user).not_to be_valid
      end
    end

    context '姓・名（全角）' do
      it '姓（全角）が空では登録できないこと' do
        @user.firstname_kanji = nil
        expect(@user).not_to be_valid
      end

      it '姓（全角）に半角文字が含まれていると登録できないこと' do
        @user.firstname_kanji = 'Yamada'
        expect(@user).not_to be_valid
      end

      it '名（全角）が空では登録できないこと' do
        @user.lirstname_kanji = nil
        expect(@user).not_to be_valid
      end

      it '名（全角）に半角文字が含まれていると登録できないこと' do
        @user.lirstname_kanji = 'Taro'
        expect(@user).not_to be_valid
      end
    end

    context '姓・名（カナ）' do
      it '姓（カナ）が空では登録できないこと' do
        @user.firstname_kana = nil
        expect(@user).not_to be_valid
      end

      it '姓（カナ）にカタカナ以外の文字が含まれていると登録できないこと' do
        @user.firstname_kana = 'やまだ'
        expect(@user).not_to be_valid
      end

      it '名（カナ）が空では登録できないこと' do
        @user.lastname_kana = nil
        expect(@user).not_to be_valid
      end

      it '名（カナ）にカタカナ以外の文字が含まれていると登録できないこと' do
        @user.lastname_kana = 'たろう'
        expect(@user).not_to be_valid
      end
    end

    context '生年月日' do
      it '生年月日が空では登録できないこと' do
        @user.birthday = nil
        expect(@user).not_to be_valid
      end
    end
  end
end