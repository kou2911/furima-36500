require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  context '購入できる時' do
    it '全ての内容が存在する。' do
      expect(@order_address).to be_valid
    end
  end

  context '購入ができない時' do
    it 'tokenが空だと購入できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it ' postal_codeが空だと購入できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeに-がないと購入できない' do
      @order_address.postal_code = '0000000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'postal_codeが3桁ハイフン4桁以外だと購入できない' do
      @order_address.postal_code = '0000-0000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it ' prefecture_idが空だと購入できない' do
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'municipalitiesが空だと購入できない' do
      @order_address.municipalities = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
    end

    it 'block_numberが空だと購入できない' do
      @order_address.block_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Block number can't be blank")
    end

    it 'phone_numberが空だと購入できない' do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが12桁以上だと購入できない' do
      @order_address.phone_number = '000000000000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberが9桁以下だと購入できない' do
      @order_address.phone_number = '000000000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberに-があると購入できない' do
      @order_address.phone_number = '000-0000-0000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'userが紐付いていないと保存できないこと' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'itemが紐付いていないと保存できないこと' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
  end
end
