FactoryBot.define do
  factory :card do
    card_token     {"car_3e6b661da5f33489c63b8e68f50a"}
    customer_token {"cus_126ee2d7c40991721e699f25301c"}
    association :user
  end
end