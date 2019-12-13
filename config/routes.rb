Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    get "users/:id", :to => "users/confirmations#show"
    get "profile_edit", :to => "users/registrations#profile_edit", as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

  resources :weathers, only: [:index] do
    collection do
      post :index
    end
  end
  
end
