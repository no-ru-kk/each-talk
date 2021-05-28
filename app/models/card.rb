class Card < ApplicationRecord
  belongs_to :user, optional: true
  validates :card_token, :customer_token, presence: true
end