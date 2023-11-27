require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '正常系' do
    it '全ての項目が入力されていれば登録できる' do
      @user.nickname = 'test'
      @user.email = 'test@example.com'
      @user.password = 'ValidPassword123'
      @user.password_confirmation = 'ValidPassword123'
      @user.birthday = '1990-01-01'
      @user.firstname_kanji = '田中'
      @user.lirstname_kanji = '太郎'
      @user.firstname_kana = 'タナカ'
      @user.lastname_kana = 'タロウ'

      @user.valid?
      puts @user.errors.full_messages
      expect(@user).to be_valid
    end
  end

  describe '異常系' do
    context 'nickname' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
    end

    context 'メールアドレス' do
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
    end

    context 'パスワード' do
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'パスワードが6文字未満では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'onlyletters'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password must contain at least one letter and one number"
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password must contain at least one letter and one number"
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password must contain at least one letter and one number"
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password = 'password123'
        @user.password_confirmation = 'mismatched_password'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      
    end

    context '姓・名（全角）' do
      it '姓（全角）が空だと登録できない' do
        @user.firstname_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kanji can't be blank"
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.firstname_kanji = 'Smith' # Replace with a half-width character
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kanji is invalid. Input full-width characters"
      end
      
      

      it '名（全角）が空だと登録できない' do
        @user.lirstname_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Lirstname kanji can't be blank"
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.lirstname_kanji = 'John' # Replace with a half-width character
        @user.valid?
        expect(@user.errors.full_messages).to include "Lirstname kanji is invalid. Input full-width characters"
      end
      
    end

    context '姓・名（カナ）' do
      it '姓（カナ）が空だと登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kana can't be blank"
      end

      it '姓（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.firstname_kana = 'John' # Replace with characters other than full-width katakana
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kana is invalid. Input full-width katakana characters"
      end
      
      it '名（カナ）が空だと登録できない' do
        @user.lastname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname kana can't be blank"
      end

      it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.lastname_kana = 'John' # Replace with characters other than full-width katakana
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname kana is invalid. Input full-width katakana characters"
      end
      
    end

    context '生年月日' do
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end

