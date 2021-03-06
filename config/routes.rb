# frozen_string_literal: true

Rails.application.routes.draw do
  root 'opinions#index'

  resources :opinions, only: %i[create edit update]
  resources :followings, only: %i[destroy create]

  resources :users do
    resources :opinions, except: %i[create edit update]
    resources :followings, only: [:index]
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
