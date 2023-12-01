require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '異常系' do
    context '商品名' do
      it '商品名が空では保存できない' do
        @item.item_name = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank", "Item name can't be blank"
      end
    end
    context '商品の説明' do
      it '商品の説明が空では保存できない' do  
        @item.item_explanation = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank", "Item explanation can't be blank"
      end
    end
    context '商品の詳細' do
      it 'カテゴリーが空では保存できない' do
        @item.category_id = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
      it '商品の詳細が空では保存できない' do
        @item.situation_id = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
    end


    context '配送について' do
      it '配送料が空では保存できない' do 
        @item.postage_id = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
      it '発送元の地域が空では保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
      it '発送までの日数が空では保存できない' do
        @item.deliveryday_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
    end
    context '販売価格' do
      it '¥300〜9,999,999以外' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist", "Image can't be blank", "Price can't be blank", "Price is not a number"
      end
    end
  end
end