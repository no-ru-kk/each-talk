class Dayotw < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'いつでも' },
    { id: 3, name: '平日' },
    { id: 4, name: '土日' }
  ]

  include ActiveHash::Associations
  has_many :rooms
end