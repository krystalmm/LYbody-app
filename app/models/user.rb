class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :reservation, dependent: :destroy
  has_many :rooms, dependent: :destroy

  validates :firstname, presence: true, length: { maximum: 30 }
  validates :lastname, presence: true, length: { maximum: 30 }

  VALID_KANA_REGEX = /\A[\p{katakana}\u{30fc}\s 　]+\z/.freeze
  validates :kana_firstname, presence: true, length: { maximum: 30 }, format: { with: VALID_KANA_REGEX }
  validates :kana_lastname, presence: true, length: { maximum: 30 }, format: { with: VALID_KANA_REGEX }

  validates :email, presence: true, length: { maximum: 255 }

  VALID_PHONE_REGEX = /\A\d{10,11}\z/.freeze
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }

  validates :is_payed, inclusion: { in: [true, false] }
  validates :is_valid, inclusion: { in: [true, false] }

  def fullname
    "#{firstname}　#{lastname}"
  end

  def kana_fullname
    "#{kana_firstname}　#{kana_lastname}"
  end
end
