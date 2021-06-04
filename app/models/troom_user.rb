class TroomUser < ApplicationRecord
  belongs_to :troom
  belongs_to :user
end