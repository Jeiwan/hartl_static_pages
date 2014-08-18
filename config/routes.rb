Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get '/home', to: 'static_pages#home', as: 'home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/contact', to: 'static_pages#contact', as: 'contact'
  get '/other', to: 'static_pages#other', as: 'other'

  resources :users, only: [:index, :show, :destroy]
  get '/settings', to: 'users#edit', as: 'settings'
  put '/settings', to: 'users#update'
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup' => 'users#create'

  post '/newmicropost', to: 'microposts#create', as: 'new_micropost'
	delete '/delmicropost/:id', to: 'microposts#destroy', as: 'del_micropost'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  root 'static_pages#home'
end
