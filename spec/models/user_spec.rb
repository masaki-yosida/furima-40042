# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系' do
    it '全ての項目が入力されていれば登録できる' do
      user = build(:user) # FactoryBot等を使用してユーザーオブジェクトを作成
      expect(user).to be_valid
    end
  end

  describe '異常系' do
    context 'nickname' do
      it 'nicknameが空では登録できない' do
        user = build(:user, nickname: nil)
        expect(user).not_to be_valid
      end
    end

    context 'メールアドレス' do
      it 'メールアドレスが空では登録できない' do
        user = build(:user, email: nil)
        expect(user).not_to be_valid
      end

      it '重複したメールアドレスは登録できない' do
        existing_user = create(:user, email: 'test@example.com')
        user = build(:user, email: 'test@example.com')
        expect(user).not_to be_valid
      end

      it 'メールアドレスに@を含まない場合は登録できない' do
        user = build(:user, email: 'invalid_email')
        expect(user).not_to be_valid
      end
    end

    context 'パスワード' do
      it 'パスワードが空では登録できない' do
        user = build(:user, password: nil)
        expect(user).not_to be_valid
      end

      it 'パスワードが6文字未満では登録できない' do
        user = build(:user, password: '12345')
        expect(user).not_to be_valid
      end

      it '英字のみのパスワードでは登録できない' do
        user = build(:user, password: 'abcdef')
        expect(user).not_to be_valid
      end

      it '数字のみのパスワードでは登録できない' do
        user = build(:user, password: '123456')
        expect(user).not_to be_valid
      end

      it '全角文字を含むパスワードでは登録できない' do
        user = build(:user, password: 'あいうえおabc123')
        expect(user).not_to be_valid
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        user = build(:user, password_confirmation: 'mismatch')
        expect(user).not_to be_valid
      end

      context '姓・名（全角）' do
        it '姓（全角）が空だと登録できない' do
          user = build(:user, list_name_kanji: nil)
          expect(user).not_to be_valid
        end
      
        it '姓（全角）に半角文字が含まれていると登録できない' do
          user = build(:user, list_name_kanji: 'Smith')
          expect(user).not_to be_valid
        end
      
        it '名（全角）が空だと登録できない' do
          user = build(:user, first_name_kanji: nil)
          expect(user).not_to be_valid
        end
      
        it '名（全角）に半角文字が含まれていると登録できない' do
          user = build(:user, first_name_kanji: 'John')
          expect(user).not_to be_valid
        end
      end
      
  
      context '姓・名（カナ）' do
        it '姓（カナ）が空だと登録できない' do
          user = build(:user, last_name_kana: nil)
          expect(user).not_to be_valid
        end
  
        it '姓（カナ）にカタカナ以外の文字が含まれていると登録できない' do
          user = build(:user, last_name_kana: 'たなか')
          expect(user).not_to be_valid
        end
  
        it '名（カナ）が空だと登録できない' do
          user = build(:user, first_name_kana: nil)
          expect(user).not_to be_valid
        end
  
        it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
          user = build(:user, first_name_kana: 'たろう')
          expect(user).not_to be_valid
        end
      end
  
      context '生年月日' do
        it '生年月日が空だと登録できない' do
          user = build(:user, birthdate: nil)
          expect(user).not_to be_valid
        end
      end
    end
  end
end