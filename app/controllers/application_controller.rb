class ApplicationController < ActionController::Base
  after_action :discard_flash_if_xhr

  rescue_from StandardError, with: :handle_500
  rescue_from ActiveRecord::RecordNotFound, with: :handle_404

  def handle_404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  def handle_500(e)
    ExceptionNotifier.notify_exception(e, env: request.env, data: { message: 'error' })
    render file: Rails.root.join('public', '500.html'), status: :internal_server_error, layout: false
  end

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
