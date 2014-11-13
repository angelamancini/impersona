Impersona::Application.routes.draw do
  get '/auth/:service/callback' => 'services#create'
  get '/auth/failure' => 'services#failure'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/login' => 'sessions#new', as: :login

  resources :server_arrays
  root 'server_arrays#index'

end
