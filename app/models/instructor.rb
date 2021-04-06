class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :instructor_lessons, dependent: :nullify
  has_many :lessons, through: :instructor_lessons

  mount_uploader :instructor_image, InstructorImageUploader
end
