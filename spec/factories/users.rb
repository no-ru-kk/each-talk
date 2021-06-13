FactoryBot.define do
  factory :user do
    name                  {Faker::Name.initials(number: 40)}
    introduction          {'この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、'}
    email                 {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6) 
    password {password}
    password_confirmation {password}
  end
end