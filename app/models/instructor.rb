class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :instructor_lessons, dependent: :destroy
  has_many :lessons, through: :instructor_lessons
  has_many :reservations, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :instructor_image, presence: true
  validates :has_lesson, inclusion: { in: [true, false] }
  validates :comment, presence: true, length: { maximum: 300 }

  mount_uploader :instructor_image, InstructorImageUploader
end
