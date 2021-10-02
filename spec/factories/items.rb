FactoryBot.define do
  factory :item do
    item_name        { Faker::Name.name }
    text             { Faker::Lorem.sentence }
    category_id      { 1 }
    status_id        { 1 }
    delivery_fee_id  { 1 }
    prefecture_id    { 1 }
    sipping_day_id   { 1 }
    price            { 1000 }
    association :user

    after(:build) do |image|
      image.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
