Rails.application.routes.draw do

  devise_for :instructors, only: :sessions, controllers: {
    sessions: 'instructors/sessions'
  }

  devise_for :users, only: [:sessions, :registrations], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  namespace :instructors do
    get '/' => 'homes#top'
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
  end
end
