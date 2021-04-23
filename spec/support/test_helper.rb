module SystemHelper
  def login_as(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログインする'
  end

  def instructor_login_as(instructor)
    visit new_instructor_session_path
    fill_in 'instructor_email', with: instructor.email
    fill_in 'instructor_password', with: instructor.password
    click_button 'ログインする'
  end
end

RSpec.configure do |config|
  config.include SystemHelper
end