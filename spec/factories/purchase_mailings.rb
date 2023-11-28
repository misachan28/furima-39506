FactoryBot.define do
  factory :purchase_mailing do
    postcode { Faker::Number.between(from: 100, to: 999).to_s + "-" + Faker::Number.between(from: 1000, to: 9999).to_s }
    prefecture_id { Faker::Number.between(from: 2,to: 48) }
    city{ Faker::Address.city }
    block{ Faker::Address.street_address}
    building{ Faker::Address.building_number }
    phone_number{ Faker::Number.between(from: 1000000000, to: 99999999999) }
    token{"tok_abcdefghijk00000000000000000"}
  end
end
