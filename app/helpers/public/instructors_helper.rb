module Public::InstructorsHelper
  def payed(user)
    user.is_payed == true
  end
end
