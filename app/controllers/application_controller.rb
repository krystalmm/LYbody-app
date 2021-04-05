class ApplicationController < ActionController::Base
  protected
  def after_sign_in_path_for(resource)
    case resource
    when Instructor
      instructors_path
    when User
      if current_user.is_valid == true
        my_page_users_path
      else
        reset_session
        flash[:notice] = 'このユーザーは退会済みです'
        new_user_session_path
      end
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
