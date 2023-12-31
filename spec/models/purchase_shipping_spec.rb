require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '商品購入記録の保存' do
    before do
       @user = FactoryBot.create(:user)
       @item = FactoryBot.create(:item)
       @purchase_shipping = FactoryBot.build(:purchase_shipping,user_id: @user.id, item_id: @item.id)
    end

    context '正常系' do
      it 'すべての値が正しく入力されていれば購入できること' do
       
        expect(@purchase_shipping).to be_valid
      end
      it '建物名が空でも購入できること' do
        @purchase_shipping.building_name = ''
        expect(@purchase_shipping).to be_valid
      end
    end

    context '異常系' do
      it '郵便番号は空では保存できないこと' do
        @purchase_shipping.post_code = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
        @purchase_shipping = FactoryBot.build(:purchase_shipping, post_code: 'invalid_code')
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Post code は「3桁ハイフン4桁」の形式で入力してください")
      end
      it '都道府県に「---」が選択されている場合は購入できないこと' do
        @purchase_shipping.prefecture_id = '1'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと購入できないこと' do
        @purchase_shipping.municipalities = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地が空だと購入できないこと' do
        @purchase_shipping.street_address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が空だと購入できないこと' do
        @purchase_shipping.telephone_number = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号が9桁以下だと購入できないこと' do
        @purchase_shipping.telephone_number = '090123456'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number は10桁以上11桁以内の半角数値で入力してください")
      end
      it '電話番号が12桁以上だと購入できない' do
        @purchase_shipping.telephone_number = '01234567890123'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number は10桁以上11桁以内の半角数値で入力してください")
      end
      it '電話番号が半角数値でないと購入できないこと' do
        @purchase_shipping.telephone_number = '123456789a'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number は10桁以上11桁以内の半角数値で入力してください")
      end
      it 'tokenが空では購入できないこと' do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが紐づいていなければ購入できないこと' do
        @purchase_shipping.user_id = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていなければ購入できないこと' do
        @purchase_shipping.item_id = ''
        @purchase_shipping.valid?

        expect(@purchase_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
