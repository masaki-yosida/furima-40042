# config/routes.rb

Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items do
    member do
      delete 'destroy'
    end
  end
end
