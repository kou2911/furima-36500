class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :block_number, :building, :phone_number, :token


  with_options presence: true do
    validates :municipalities
    validates :block_number
    validates :token
    validates :user_id
    validates :item_id
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
    validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities,
                   block_number: block_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end
