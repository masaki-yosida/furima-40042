require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '異常系' do
    context '商品画像' do
      it '商品画像が空では保存できない' do
        item = Item.new(
          item_name: '',
          item_explanation: 'This is a sample product description.',
          image: ``,
          category_id: Category.create(name: 'Some Category').id,
          situation_id: Situation.create(name: 'Some Situation').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank", "Item name can't be blank"
      end
    end
    context '商品名' do
      it '商品名が空では保存できない' do
        item = Item.new(
          item_name: '',
          item_explanation: 'This is a sample product description.',
          image: nil,
          category_id: Category.create(name: 'Some Category').id,
          situation_id: Situation.create(name: 'Some Situation').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank", "Item name can't be blank"
      end
    end
    context '商品の説明' do
      it '商品の説明が空では保存できない' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: '',
          image: nil,
          category_id: Category.create(name: 'Some Category').id,
          situation_id: Situation.create(name: 'Some Situation').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank", "Item explanation can't be blank"
      end
    end
    context '商品の詳細' do
      it 'カテゴリーが空では保存できない' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: 'あああ',
          image: nil,
          category_id: Category.create(name: '').id,
          situation_id: Situation.create(name: 'Some Situation').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
      it '商品の詳細が空では保存できない' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: 'あああ',
          image: nil,
          category_id: Category.create(name: 'Some Situation').id,
          situation_id: Situation.create(name: '').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
    end


    context '配送について' do
      it '配送料が空では保存できない' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: 'あああ',
          image: nil,
          category_id: Category.create(name: 'ggd').id,
          situation_id: Situation.create(name: 'Some Situation').id,
          postage_id: Postage.create(name: '').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
      it '発送元の地域が空では保存できない' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: 'あああ',
          image: nil,
          category_id: Category.create(name: 'Some Situation').id,
          situation_id: Situation.create(name: 'ds').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: '').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
      it '発送までの日数が空では保存できない' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: 'あああ',
          image: nil,
          category_id: Category.create(name: 'Some Situation').id,
          situation_id: Situation.create(name: 'ds').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '').id,
          price: 1000
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank"
      end
    end
    context '販売価格' do
      it '¥300〜9,999,999以外' do
        item = Item.new(
          item_name: '鷹',
          item_explanation: 'あああ',
          image: nil,
          category_id: Category.create(name: 'Some Situation').id,
          situation_id: Situation.create(name: 'dd').id,
          postage_id: Postage.create(name: '送料込み(出品者負担)').id,
          prefecture_id: Prefecture.create(name: 'Tokyo').id,
          deliveryday_id: Deliveryday.create(name: '2 days').id,
          price: 150
        )
        item.valid?
        expect(item.errors.full_messages).to include "User must exist", "Image can't be blank", "Price must be greater than or equal to 300"
      end
    end

    
    


    # ... (rest of the context blocks remain unchanged)
  end
end