module Rightscale
  require 'right_api_client'
  class ServerArray
    def get_server_array(array_id, account_id)
      client = RightApi::Client.new(email: ENV['rs_email'],
                                    password: ENV['rs_password'],
                                    account_id: account_id)
      client.server_arrays(id: array_id).show
    end

    def get_inputs(array_id, account_id)
      input_hash = {}
      server_array = get_server_array(array_id, account_id)
      array_name = server_array.name
      inputs = server_array.current_instances.index.first.inputs.index
      inputs.each do |input|
        input_hash[input.name] = input.value
      end
      return array_name, input_hash
    end
  end
  class Deployment
  end
end
