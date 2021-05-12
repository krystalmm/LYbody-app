class Instructor::SessionsController < Devise::SessionsController
  def guest_sign_in
    instructor = Instructor.find(1)
    sign_in instructor
    redirect_to instructors_mypage_path, notice: 'インストラクター jean としてログインしました。'
  end
end
