Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }

  root 'weathers#index'

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

  resources :tweets, only: [:index, :create, :destroy, :edit, :update] do
    collection do
      get :result
    end
  end

  resources :sub_areas, only: [:create] do
    collection do
      delete :delete
    end
  end

  resources :trusts, only: [:create] do
    collection do
      delete :delete
    end
  end
  
end
