class DeploymentsController < ApplicationController
  include DeploymentsHelper
  def deployment
  end

  def get_deployment_inputs
    @origin_name, @origin = deployment_inputs(params[:origin_deployment_id], params[:origin_account_id])
    @input_select_types = ['inherit', 'text', 'cred', 'env', 'key']
  end

  def post_deployment_inputs
    @destination = params[:destination]
    @inputs = params[:input_data]
    array_name = update_deployment_inputs(@destination, @inputs)
    flash[:notice] = "Inputs copied to #{array_name}"
    redirect_to deployments_path
  end
end
