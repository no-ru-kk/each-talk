class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :introduction, presence: true

  has_one :card, dependent: :destroy
  has_many :rooms
  has_many :room_orders
end