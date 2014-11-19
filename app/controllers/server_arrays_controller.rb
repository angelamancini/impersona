class ServerArraysController < ApplicationController
  include ServerArraysHelper
  def server_array
  end

  def get_array_inputs
    @origin_name, @origin = server_array_inputs(params[:origin_array_id], params[:origin_account_id])
    @input_select_types = ['inherit', 'text', 'cred', 'env', 'key']
    respond_to do |format|
      format.js
    end
  end

  def copy_array_inputs
  end
end
