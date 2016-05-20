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
    Rightscale::ServerArray.get_inputs(array_id, account_id)
  end

  def update_server_array_inputs(account_id, array_id, inputs)
    Rightscale::ServerArray.update_inputs(array_id, account_id, inputs)
  end
end
