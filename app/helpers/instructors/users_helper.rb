module Instructors::UsersHelper
  def is_valid_value(user)
    if user.is_valid == true
      "有効"
    else
      "無効"
    end
  end
end
