Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "application#hello"

  resources :users, only: [:show, :new, :create]
  resources :cocktails, only: [:show, :new, :create]
 
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/github/callback', to: 'sessions#create'


  resources :users do 
    resources :cocktails, only: [:new, :create, :show]
  end 
  
end
