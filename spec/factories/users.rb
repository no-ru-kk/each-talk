FactoryBot.define do
  factory :user do
    name                  {Faker::Name.initials(number: 40)}
    introduction          {'この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、'}
    email                 {Faker::Internet.free_email}
    password              {'2021te'}
    password_confirmation {password}
  end
end
