class Mtime < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '00分' },
    { id: 3, name: '15分' },
    { id: 4, name: '30分' },
    { id: 5, name: '45分' }
  ]

  include ActiveHash::Associations
  has_many :rooms
end