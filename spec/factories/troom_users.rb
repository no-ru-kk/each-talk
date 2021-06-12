FactoryBot.define do
  factory :troom_user do
    association :user
    association :troom
  end
end