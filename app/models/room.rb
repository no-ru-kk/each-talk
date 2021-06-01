class Room < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # has_many :room_users
  # has_many :users, through: room_users
  belongs_to :user
  # has_many :messages
  belongs_to :dayotw
  belongs_to :rtime
  belongs_to :htime
  belongs_to :mtime
  has_one    :room_order
  has_one_attached :image

  validates :name, :rexplain, presence: true, unless: :was_attached?
  validates :dayotw_id, :rtime_id, :htime_id, :mtime_id, numericality: { other_than: 1 } 
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 500, less_than_or_equal_to: 10000 }, format: {with: /\A[0-9]+\z/i, message: "is invalid. Input half-width number."}

  def was_attached?
    self.image.attached?
  end
end