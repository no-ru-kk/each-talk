class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :introduction, presence: true

  has_many :rooms
  has_many :troom_users
  has_many :trooms, through: :troom_users
  has_one :card, dependent: :destroy
  has_many :room_orders
end