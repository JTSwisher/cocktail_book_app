Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "application#hello"

  resources :users, only: [:show, :new, :create]
  get 'cocktails/highest-rated', to: 'favorites#index', as: 'favorites'
  resources :cocktails, only: [:show, :new, :create, :index]
  post 'cocktails/query', to: 'cocktails#index', as: 'search_cocktails'
 
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/github/callback', to: 'sessions#create'

  

  

  resources :users do 
    resources :cocktails, only: [:show, :new, :create, :index, :edit, :update, :destroy]
  end 

  resources :users do 
    resources :favorites, only: [:show, :create, :index, :edit, :update, :destroy]
  end 

  get 'users/:user_id/favorites', to: 'favorites#new', as: 'new_user_favorite'

  

  
end
