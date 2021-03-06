class ServerArraysController < ApplicationController
  include ServerArraysHelper
  def server_array
  end

  def get_array_inputs
    @origin_name, @origin = server_array_inputs(params[:origin_array_id], params[:origin_account_id])
    @input_select_types = ['inherit', 'text', 'cred', 'env', 'key']
  end

  def post_array_inputs
    @dest_account_id = params[:dest_account_id]
    @dest_array_id = params[:dest_array_id]
    @inputs = params[:input_data]

    array_name = update_server_array_inputs(@dest_account_id, @dest_array_id, @inputs)
    flash[:notice] = "Inputs copied to #{array_name}"
    redirect_to server_arrays_path
  end
end
