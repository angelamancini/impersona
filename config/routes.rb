Impersona::Application.routes.draw do
  get '/auth/:service/callback' => 'services#create'
  get '/auth/failure' => 'services#failure'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/login' => 'sessions#new', as: :login
  get '/server_arrays' => 'server_arrays#server_array', as: :server_arrays
  get '/deployments' => 'deployments#deployment', as: :deployments
  get '/get_array_inputs' => 'server_arrays#get_array_inputs', as: :get_array_inputs
  get '/get_deployment_inputs' => 'deployments#get_deployment_inputs', as: :get_deployment_inputs
  post '/post_array_inputs' => 'server_arrays#post_array_inputs', as: :post_array_inputs
  post '/post_deployment_inputs' => 'deployments#post_deployment_inputs', as: :post_deployment_inputs
  root 'server_arrays#server_array'

end
