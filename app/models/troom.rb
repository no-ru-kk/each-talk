class Troom < ApplicationRecord
  has_many :troom_users
  has_many :users, through: :troom_users
  has_many :messages
  belongs_to :room
end