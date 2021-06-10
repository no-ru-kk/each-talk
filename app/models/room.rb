class Room < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one    :troom
  belongs_to :dayotw
  belongs_to :rtime
  belongs_to :htime
  belongs_to :mtime
  has_one    :room_order
  has_one_attached :image

  validates :name, :rexplain, presence: true, unless: :was_attached?
  validates :dayotw_id, :rtime_id, :htime_id, :mtime_id, numericality: { other_than: 1, message: "は「---」以外を選択してください"} 
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 500, less_than_or_equal_to: 10000 }, format: {with: /\A[0-9]+\z/i, message: "は半角数値で入力してください"}

  def was_attached?
    self.image.attached?
  end
end