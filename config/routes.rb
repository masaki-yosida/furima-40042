Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  get '/items/new', to: 'items#new', as: 'new_item'

  resources :users do
    resources :items
  end
end
