Rails.application.routes.draw do

  devise_for :instructors, only: :sessions, controllers: {
    sessions: 'instructors/sessions'
  }

  devise_scope :instructor do
    post 'instructors/guest_sign_in' => 'instructor/sessions#guest_sign_in'
  end

  devise_for :users, only: [:sessions, :registrations], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end

  namespace :instructors do
    get '/mypage' => 'instructors#show'
    resources :lessons, only: [:create, :destroy]
    resources :users, only: [:index, :show]
    resources :reviews, only: [:destroy]
    resources :reservations, only: [:update, :destroy]
    resources :rooms, only: [:show]
    get 'rooms/:id/:page' => 'rooms#pagination', as: 'room_pagination'
    resource :chats, only: [:create]
    get '/search' => 'search#search'
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

    resources :instructors, only: [:index, :show] do
      resources :reviews, only: [:create, :destroy]
    end
    resources :reservations, only: [:index, :create, :update, :destroy]
    resources :rooms, only: [:show]
    get 'rooms/:id/:page' => 'rooms#pagination', as: 'room_pagination'
    resource :chats, only: [:create]
    resources :cards, only: [:new, :show, :create] do
      collection do
        post 'cancel' => 'cards#cancel'
      end
    end
    resources :contacts, only: [:new, :create]
    post 'contacts/confirm' => 'contacts#confirm', as: 'confirm'
    post 'contacts/back' => 'contacts#back', as: 'back'
  end
end
