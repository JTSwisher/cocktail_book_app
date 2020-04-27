Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "application#index"

  resources :users, only: [:show, :new, :create]
  
  get 'cocktails/highest_rated', to: 'highest_rated#index', as: 'favorites'
  get 'cocktails/query', to: 'cocktails#index', as: 'search_cocktails'
  resources :cocktails, only: [:show, :new, :create, :index] do 
    resources :favorites, only: [:index]
  end 
  
 
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout/:id', to: 'sessions#destroy', as: 'logout'
  get '/auth/github/callback', to: 'sessions#create'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  
 
  resources :users do 
    resources :cocktails, only: [:show, :new, :create, :index, :edit, :update, :destroy]
  end 

  resources :users do 
    resources :favorites, only: [:show, :new, :create, :index, :edit, :update, :destroy]
  end 
  
end
