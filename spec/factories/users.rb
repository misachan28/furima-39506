FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials}
    email {Faker::Internet.email}
    password {'a1' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name {'やマだ'}
    first_name {'一ろウ'}
    last_name_kana {'ヤマダ'}
    first_name_kana {'タロウ'}
    birthday {Faker::Date.between(from: '1930-01-01', to: '2017-12-31')}
  end
end 