Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }

  devise_scope :user do
    get "mypage/:id", :to => "users/confirmations#show", as: 'mypage'
    get "profile_edit", :to => "users/registrations#profile_edit", as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

  resources :weathers, only: [:index] do
    collection do
      post :index
    end
  end
  
end
