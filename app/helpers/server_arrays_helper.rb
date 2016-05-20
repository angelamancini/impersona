module ServerArraysHelper
  include Rightscale

  def rs_accounts
    account_hash = RIGHTSCALE_CONFIG['accounts']
    accounts = []
    account_hash.each do |account|
      accounts.push([account['name'].capitalize, account['id']])
    end
    return accounts
  end

  def server_array_inputs(array_id, account_id)
    ServerArray.get_inputs(array_id, account_id)
  end

  def update_server_array_inputs(destination, inputs)
    ServerArray.update_inputs(destination[:array_id], destination[:account_id], inputs)
  end
end
