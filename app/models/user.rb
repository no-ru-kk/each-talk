class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 40 }
  validates :introduction, presence: true, length: { maximum: 100 }
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は英数含めた半角6文字以上で入力ください"}
  # validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "is invalid. Input both half-width alphanumeric characters with 6 characters or more."}

  has_many :rooms
  has_many :troom_users
  has_many :trooms, through: :troom_users
  has_one :card, dependent: :destroy
  has_many :room_orders
end