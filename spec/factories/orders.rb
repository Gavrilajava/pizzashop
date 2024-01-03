FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    text_messages_enabled { [true, false].sample }
    item { Order.items.keys.sample }
  end
end
