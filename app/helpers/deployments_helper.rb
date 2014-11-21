module DeploymentsHelper
  include Rightscale

  def deployment_inputs(array_id, account_id)
    Deployment.new.get_inputs(array_id, account_id)
  end

  def update_deployment_inputs(destination, inputs)
    Deployment.new.update_inputs(destination[:deployment_id], destination[:account_id], inputs)
  end
end
