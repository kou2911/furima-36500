FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id   { 1 }
    municipalities  { Faker::Address.city }
    block_number    { Faker::Address.street_address }
    building        { Faker::Address.secondary_address }
    phone_number    { '09091111111' }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
