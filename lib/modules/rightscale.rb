module Rightscale
  require 'right_api_client'
  class Credential

    def new_cred(account_id, name, value, description)
      client = RightApi::Client.new(email: ENV['rs_email'],
      password: ENV['rs_password'],
      account_id: account_id)
      credential_hash = { name: name, value: value, description:  }
      client.credentials.create(credential:credential_hash)
    end
  end

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
      inputs = server_array.current_instances.index.first.inputs.index
      inputs.each do |input|
        split = input.value.split(':')
        sections = split.count - 1
        value = split[1..sections].join(':')
        type = split.first
        input_hash[input.name] = [type, value]
      end
      return server_array.name, input_hash
    end

    def account_credentials(account_id)
      client = RightApi::Client.new(email: ENV['rs_email'],
      password: ENV['rs_password'],
      account_id: account_id)
      credentials = client.credentials.index(:view =>'sensitive')
    end

    def update_inputs(array_id, account_id, inputs)
      credentials = account_credentials(account_id)
      input_hash = {}
      inputs.each do |input|
        input_hash[input.first] = "#{input.last['type']}:#{input.last['value']}"
      end
      server_array = get_server_array(array_id, account_id)
      server_array.next_instance.show.inputs
      .multi_update(inputs: input_hash)
      return server_array.name
    end
  end
  class Deployment
    def get_deployment(deployment_id, account_id)
      client = RightApi::Client.new(email: ENV['rs_email'],
      password: ENV['rs_password'],
      account_id: account_id)
      client.deployments(id: deployment_id).show
    end

    def get_inputs(deployment_id, account_id)
      input_hash = {}
      deployment = get_deployment(deployment_id, account_id)
      inputs = deployment.inputs.index
      inputs.each do |input|
        split = input.value.split(':')
        sections = split.count - 1
        value = split[1..sections].join(':')
        type = split.first
        input_hash[input.name] = [type, value]
      end
      return deployment.name, input_hash
    end

    def update_inputs(deployment_id, account_id, inputs)
      input_hash = {}
      inputs.each do |input|
        input_hash[input.first] = "#{input.last['type']}:#{input.last['value']}"
      end
      deployment = get_deployment(deployment_id, account_id)
      deployment.inputs.multi_update(inputs: input_hash)
      return deployment.name
    end
  end
end
