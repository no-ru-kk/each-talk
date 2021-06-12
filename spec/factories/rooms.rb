FactoryBot.define do
  factory :room do
    name      {Faker::Name.initials(number: 16)}
    rexplain  {Faker::Lorem.sentence}
    dayotw_id {Faker::Number.between(from: 2, to: 4)}
    rtime_id  {Faker::Number.between(from: 2, to: 4)}
    htime_id  {Faker::Number.between(from: 2, to: 25)}
    mtime_id  {Faker::Number.between(from: 2, to: 5)}
    price     {Faker::Number.between(from: 500, to: 10000)}
    image     {Faker::Lorem.sentence}
    association :user

    after(:build) do |room|
      room.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end