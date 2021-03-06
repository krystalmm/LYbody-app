class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :reservation, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_one :card, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :firstname, presence: true, length: { maximum: 15 }
  validates :lastname, presence: true, length: { maximum: 15 }

  VALID_KANA_REGEX = /\A[\p{katakana}\u{30fc}\s 　]+\z/.freeze
  validates :kana_firstname, presence: true, length: { maximum: 15 }, format: { with: VALID_KANA_REGEX }
  validates :kana_lastname, presence: true, length: { maximum: 15 }, format: { with: VALID_KANA_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }

  VALID_PHONE_REGEX = /\A\d{10,11}\z/.freeze
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }

  validates :is_payed, inclusion: { in: [true, false] }
  validates :is_valid, inclusion: { in: [true, false] }

  mount_uploader :icon_image, UserImageUploader

  def fullname
    "#{firstname}　#{lastname}"
  end

  def kana_fullname
    "#{kana_firstname}　#{kana_lastname}"
  end

  def self.looks(words)
    @users = User.where(['concat(firstname, lastname) LIKE ?', "%#{words}%"])
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.firstname = 'ゲスト'
      user.lastname = 'ユーザー'
      user.kana_firstname = 'ゲスト'
      user.kana_lastname = 'ユーザー'
      user.phone_number = '00000000000'
    end
  end
end
