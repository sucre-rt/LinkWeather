Rails.application.routes.draw do

  resources :weathers, only: [:index]
end
