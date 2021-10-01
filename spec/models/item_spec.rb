require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context "出品できる時" do
    it "全ての内容が存在する。" do
      expect(@item).to be_valid
    end
  end

  context "出品ができない時" do
    it "imageが空だと出品できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it "item_nameが空だと出品ができない" do
      @item.item_name =""
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")

    end

    it "textが空だと出品できない" do
      @item.text =""
      @item.valid?
      expect(@item.errors.full_messages).to include("Text can't be blank")

      
    end

    it "category_idが空だと出品できない" do
      @item.category_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it "status_idが空だと出品できない" do
      @item.status_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end

    it "delivery_fee_idが空だと出品できない" do
      @item.delivery_fee_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      
    end

    it "prefecture_idが空だと出品できない" do
      @item.prefecture_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it "sipping_day_idが空だと出品できない" do
      @item.sipping_day_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Sipping day can't be blank")
    end

    it "priceが空だと出品できない" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it "priceが300円以下だと出品できない" do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it "priceが9,999,999円以上だと出品できない" do
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end

    it "priceが半角数値以外だと出品できない" do
      @item.price = "１０００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it 'userが紐付いていないと保存できないこと' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
