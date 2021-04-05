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
    resource :users, only: [:edit, :update] do
      collection do
        patch 'withdraw' => 'users#withdraw', as: 'withdraw'
        get 'unsubcribe' => 'users#unsubcribe', as: 'unsubcribe'
        get 'my_page' => 'users#show'
      end
    end
  end
end
