Impersona::Application.routes.draw do

  get '/server_arrays' => 'server_arrays#server_array', as: :server_arrays
  get '/get_array_inputs' => 'server_arrays#get_array_inputs', as: :get_array_inputs
  post '/post_array_inputs' => 'server_arrays#post_array_inputs', as: :post_array_inputs
  root 'server_arrays#server_array'

end
