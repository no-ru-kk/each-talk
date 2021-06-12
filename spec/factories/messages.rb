FactoryBot.define do
  factory :message do
    content     {Faker::Lorem.sentence}
    association :troom
    association :user

    after(:build) do |room|
      room.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end