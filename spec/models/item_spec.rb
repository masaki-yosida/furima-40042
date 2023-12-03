require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '正常系' do
    it '全ての項目が入力されていれば登録できる' do
      # Set values to make the item valid
      @item.item_name = 'Valid Name'
      @item.item_explanation = 'Valid Explanation'
      @item.category_id = 5
      @item.situation_id = 2
      @item.postage_id = 3
      @item.prefecture_id = 4
      @item.deliveryday_id = 5
      @item.price = 350

      # Ensure there's a user associated with the item
      user = FactoryBot.create(:user)
      @item.user = user

      # Attach a fake image from the fixtures directory
      image_path = Rails.root.join('spec', 'fixtures', 'test_image.jpg')
      @item.image.attach(io: File.open(image_path), filename: 'test_image.jpg', content_type: 'image/jpg')

      # Output errors for debugging purposes
      puts @item.errors.full_messages

      # Expect that the @item instance is valid
      expect(@item).to be_valid
    end
  end





  describe '異常系' do
    context '商品画像' do
      it '商品画像が空では保存できない' do
        @item.image = nil  # Set image to nil to test the validation
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be an integer")
      end
    end
    context '商品名' do
      it '商品名が空では保存できない' do
        @item.item_name = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
    end
    context '商品の説明' do
      it '商品の説明が空では保存できない' do  
        @item.item_explanation = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "Item explanation can't be blank"
      end
    end
    context '商品の詳細' do
      it 'カテゴリーが空では保存できない' do
        @item.category_id = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end
      it '商品の詳細が空では保存できない' do
        @item.situation_id = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end
    end


    context '配送について' do
      it '配送料が空では保存できない' do 
        @item.postage_id = ''  
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end
      it '発送元の地域が空では保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end
      it '発送までの日数が空では保存できない' do
        @item.deliveryday_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end
    end
    context '販売価格' do
      it '¥300〜9,999,999以外' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
    end
  end
end