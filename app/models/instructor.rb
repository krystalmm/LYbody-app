class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :instructor_lessons, dependent: :destroy
  has_many :lessons, through: :instructor_lessons
  has_many :reservations, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :email, presence: true, length: { maximum: 255 }

  mount_uploader :instructor_image, InstructorImageUploader
end
