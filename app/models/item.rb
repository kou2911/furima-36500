class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :sipping_day
  belongs_to :prefecture
  
  validates :image, presence: true
  validates :item_name, presence: true
  validates :text     , presence: true
  validates :category_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :status_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :sipping_day_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :delivery_fee_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 0 , message: "can't be blank"}
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to:300, less_than_or_equal_to:9999999},
               presence: true
  end
end
