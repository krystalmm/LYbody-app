Rails.application.routes.draw do

  devise_for :instructors, only: :sessions, controllers: {
    sessions: 'instructors/sessions'
  }

  devise_for :users, only: [:sessions, :registrations], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  namespace :instructors do
    get '/mypage' => 'instructors#show'
    resources :lessons, only: [:create, :destroy]
    resources :users, only: [:index, :show]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    put 'users/withdraw' => 'users#withdraw'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update'
    put 'users/information' => 'users#update'

    resources :instructors, only: [:index, :show]
    resources :reservations, only: [:index, :create]
  end
end
