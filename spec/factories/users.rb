FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email    { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { '吉本' }
    first_name { '康二' }
    last_name_reading { 'ヨシモト' }
    first_name_reading { 'コウジ' }
    birthday { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
  end
end
