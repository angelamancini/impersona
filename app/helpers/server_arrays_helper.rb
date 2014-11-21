module ServerArraysHelper
  include Rightscale

  def server_array_inputs(array_id, account_id)
    ServerArray.new.get_inputs(array_id, account_id)
  end

  def update_server_array_inputs(destination, inputs)
    ServerArray.new.update_inputs(destination[:array_id], destination[:account_id], inputs)
  end
end
