class Rtime < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '20分' },
    { id: 3, name: '40分' },
    { id: 4, name: '60分' }
  ]

  include ActiveHash::Associations
  has_many :rooms
end