class Review < ApplicationRecord
  belongs_to :instructor
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 800 }
end
