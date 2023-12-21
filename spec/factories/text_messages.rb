FactoryBot.define do
  factory :text_message do
    sid { Faker::Invoice.creditor_reference }
    activity { FactoryBot.create(:order) }
    body { Faker::Marketing.buzzwords }
    from { Faker::PhoneNumber.cell_phone }
    to { Faker::PhoneNumber.cell_phone }
    status { %w[error queued sent].sample }
    error_message { Faker::Marketing.buzzwords }
    error_code { Faker::Number.hexadecimal(digits: 4) }
  end
end
