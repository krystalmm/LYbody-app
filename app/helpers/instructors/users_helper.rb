module Instructors::UsersHelper
  def valid_value?(user)
    if user.is_valid == true
      '有効'
    else
      '無効'
    end
  end
end
