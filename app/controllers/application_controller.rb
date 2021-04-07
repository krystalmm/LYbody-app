class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    case resource
    when Instructor
      instructors_mypage_path
    when User
      mypage_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :instructor
      new_instructor_session_path
    else
      root_path
    end
  end
end
