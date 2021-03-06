module Rightscale
  require 'right_api_client'
  class Credential
    def self.account_credentials(account_id)
      client = RightApi::Client.new(email: RIGHTSCALE_CONFIG['rs_email'],
        password: RIGHTSCALE_CONFIG['rs_password'],
        account_id: account_id,
        timeout: nil)
      raw_credentials = client.credentials.index(:view =>'sensitive')
      credentials = []
      raw_credentials.each do |raw|
        clean_cred = {}
        clean_cred[:name] = raw.name
        clean_cred[:value] = raw.value
        clean_cred[:description] = raw.description
        credentials.push(clean_cred)
      end
      return credentials
    end

    def self.new_cred(account_id, name, value, description)
      begin
        client = RightApi::Client.new(email: RIGHTSCALE_CONFIG['rs_email'],
          password: RIGHTSCALE_CONFIG['rs_password'],
          account_id: account_id,
          timeout: nil)
        credential_hash = { name: name, value: value }
        client.credentials.create(credential:credential_hash)
      rescue RightApi::ApiError => e
        if e.message.include?("Name has already been taken")
          return "Name has already been taken"
        end
      end
    end
  end

  class ServerArray
    def self.get_server_array(array_id, account_id)
      client = RightApi::Client.new(email: RIGHTSCALE_CONFIG['rs_email'],
        password: RIGHTSCALE_CONFIG['rs_password'],
        account_id: account_id,
        timeout: nil)
      client.server_arrays(id: array_id).show
    end

    def self.get_inputs(array_id, account_id)
      input_array = []
      server_array = get_server_array(array_id, account_id)
      inputs = server_array.current_instances.index.first.inputs.index
      inputs.each do |input|
        split = input.value.split(':')
        sections = split.count - 1
        value = split[1..sections].join(':')
        type = split.first
        new_input = {}
        new_input[:name] = input.name
        new_input[:type] = type
        new_input[:value] = value
        input_array.push(new_input)
      end
      return server_array.name, input_array
    end

    def self.update_inputs(array_id, account_id, inputs)
      Rails.logger.info "Starting input import into account: #{account_id} and array: #{array_id}."
      # grab the credentials from the account and make them easier to read. Do this once!
      credentials = Credential.account_credentials(account_id)
      input_hash = {}
      inputs.each do |input|
        if input["type"] == 'cred' && input["new_cred_name"] != ""
          c = credentials.find { |c| c[:name] == input["value"] }
          cred = Credential.new_cred(account_id, input["new_cred_name"], c[:value], c[:description])
          if cred == "Name has already been taken"
            Rails.logger.info "Credential #{input["new_cred_name"]} already exists, skipping creation."
          else
            Rails.logger.info "Credential #{input["new_cred_name"]} has been created in account: #{account_id}"
          end
          input_value = input["new_cred_name"]
        else
          input_value = input["value"]
        end
        input_hash[input["name"]] = "#{input["type"]}:#{input_value}"
        Rails.logger.info "Input: #{input["name"]} has been updated with #{input["type"]}:#{input_value}."
      end
      server_array = get_server_array(array_id, account_id)
      server_array.next_instance.show.inputs
      .multi_update(inputs: input_hash)
      return server_array.name
    end
  end
end
