class Room < ApplicationRecord
  belongs_to :user
  belongs_to :instructor
  has_many :chats, dependent: :destroy
end
