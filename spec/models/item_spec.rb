require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '異常系' do
    let(:user) { create(:user) } # Assuming you have a User factory

    context '商品画像' do
      it '商品画像が空では登録できない' do
        item = build(:item, user: user, image: nil)
        expect(item).to_not be_valid
        binding.pry
        expect(item.errors[:image]).to include("can't be blank")
      end
    end

    context '商品名' do
      it '商品名が空では登録できない' do
        item = build(:item, user: user, item_name: nil)
        expect(item).to_not be_valid
        expect(item.errors[:item_name]).to include("can't be blank")
      end
    end

    context '商品説明' do
      it '商品説明が空では登録できない' do
        item = build(:item, user: user, item_explanation: nil)
        expect(item).to_not be_valid
        expect(item.errors[:item_explanation]).to include("can't be blank")
      end
    end

    context '商品紹介' do
      it 'カテゴリーが---だと登録できない' do
        item = build(:item, user: user, category: nil)
        expect(item).to_not be_valid
        expect(item.errors[:category]).to include("can't be blank")
      end

      it '商品状態が---だと登録できない' do
        item = build(:item, user: user, situation: nil)
        expect(item).to_not be_valid
        expect(item.errors[:situation]).to include("can't be blank")
      end
    end

    context '配送について' do
      it '配送料の負担が---だと登録できない' do
        item = build(:item, user: user, postage: nil)
        expect(item).to_not be_valid
        expect(item.errors[:postage]).to include("can't be blank")
      end

      it '配送元の地域が---だと登録できない' do
        item = build(:item, user: user, prefecture: nil)
        expect(item).to_not be_valid
        expect(item.errors[:prefecture]).to include("can't be blank")
      end

      it '発送までの日数が---だと登録できない' do
        item = build(:item, user: user, deliveryday: nil)
        expect(item).to_not be_valid
        expect(item.errors[:deliveryday]).to include("can't be blank")
      end
    end

    context '販売価格' do
      it '販売価格が空だと登録できない' do
        item = build(:item, user: user, price: nil)
        expect(item).to_not be_valid
        expect(item.errors[:price]).to include("can't be blank")
      end

      it '販売価格が300未満だと登録できない' do
        item = build(:item, user: user, price: 299)
        expect(item).to_not be_valid
        expect(item.errors[:price]).to include("must be greater than or equal to 300")
      end

      it '販売価格が9,999,999より大きいと登録できない' do
        item = build(:item, user: user, price: 10_000_000)
        expect(item).to_not be_valid
        expect(item.errors[:price]).to include("must be less than or equal to 9999999")
      end
    end
  end
end
