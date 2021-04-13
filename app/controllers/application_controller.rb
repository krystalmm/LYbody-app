class ApplicationController < ActionController::Base
  after_action :discard_flash_if_xhr

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

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end
end
