class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def fullname
    self.firstname + '　' + self.lastname
  end

  def kana_fullname
    self.kana_firstname + '　' + self.kana_lastname
  end
end
