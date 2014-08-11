Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get '/home', to: 'static_pages#home', as: 'home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/contact', to: 'static_pages#contact', as: 'contact'
  get '/other', to: 'static_pages#other', as: 'other'

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup' => 'users#create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  root 'static_pages#home'
end
