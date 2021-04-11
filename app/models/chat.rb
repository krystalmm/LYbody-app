class Chat < ApplicationRecord
  belongs_to :room

  validates :message, presence: true
  validates :is_user, inclusion: { in: [true, false] }
end
