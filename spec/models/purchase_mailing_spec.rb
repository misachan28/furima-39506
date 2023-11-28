require 'rails_helper'

RSpec.describe PurchaseMailing, type: :model do
  describe '商品購入保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_mailing = FactoryBot.build(:purchase_mailing, user_id: user.id, item_id: item.id)
    end

    context '購入情報が保存できる場合' do
      it '必須事項を全て入力すると保存できる' do
        expect(@purchase_mailing).to be_valid
      end
      it 'buildingは任意入力であること' do
        @purchase_mailing.building = ""
        expect(@purchase_mailing).to be_valid
      end
      it 'tokenがあれば保存できる' do
        expect(@purchase_mailing).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'postcodeが空では保存できない' do
        @purchase_mailing.postcode = ''
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeがハイフンがない7桁半角数値では保存できない' do
        @purchase_mailing.postcode = '1234567'
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'postcodeが全角文字列では保存できない' do
        @purchase_mailing.postcode = '１２３−４５６７'
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'prefectureが空では保存できない' do
        @purchase_mailing.prefecture_id = '1'
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では保存できない' do
        @purchase_mailing.city = ''
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空では保存できない' do
        @purchase_mailing.block = ''
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberが空では保存できない' do
        @purchase_mailing.phone_number = ''
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁未満では保存できない' do
        @purchase_mailing.phone_number = '123456789'
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it 'phone_numberが12桁以上では保存できない' do
        @purchase_mailing.phone_number = '123456789123'
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'phone_numberが全角数値では保存できない' do
        @purchase_mailing.phone_number = '１２３４５６７８９０'
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Phone number is invalid")
      end
      it  'tokenが空では登録できないこと' do
        @purchase_mailing.token = nil
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐づいていなければ購入できない' do
        @purchase_mailing.user_id = nil
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていなければ購入できない' do
        @purchase_mailing.item_id = nil
        @purchase_mailing.valid?
        expect(@purchase_mailing.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
