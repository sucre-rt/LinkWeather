Rails.application.routes.draw do

  resources :weathers, only: [:index] do
    collection do
      post :index
    end
  end
end
