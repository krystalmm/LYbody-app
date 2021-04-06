class Lesson < ApplicationRecord

  has_many :instructor_lessons, dependent: :nullify
  has_many :instructors, through: :instructor_lessons

  validates :lesson, presence: true, length: { maximum: 50 }
end
