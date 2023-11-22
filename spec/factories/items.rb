FactoryBot.define do
  factory :item do
    nickname {Faker::Name.name}
    explanation {Faker::Lorem.sentence}
    category_id {Faker::Number.between(from: 2,to: 11)}
    condition_id {Faker::Number.between(from: 2,to: 7)}
    postage_id {Faker::Number.between(from: 2,to: 3)}
    prefecture_id {Faker::Number.between(from: 2,to: 48)}
    shipping_date_id {Faker::Number.between(from: 2,to: 4)}
    price { rand(300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.image.png'), filename: 'test.image.png')
    end
  end
end
