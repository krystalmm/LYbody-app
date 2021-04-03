class InstructorLesson < ApplicationRecord
  belongs_to :instructor
  belongs_to :lesson
end
