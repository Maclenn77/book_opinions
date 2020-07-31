Rails.application.routes.draw do

  root 'opinions#index'

  resources :opinions, only: [:create]

  resources :users do
    resources :opinions, except: [:create]
    resources :followings, only: [:create, :destroy]
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
