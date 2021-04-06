class Lesson < ApplicationRecord

  has_many :instructor_lessons, dependent: :nullify
  has_many :instructors, through: :instructor_lessons
end
