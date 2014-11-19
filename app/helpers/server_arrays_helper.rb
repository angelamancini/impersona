module ServerArraysHelper
  include Rightscale

  def server_array_inputs(array_id, account_id)
    ServerArray.new.get_inputs(array_id, account_id)
  end

  # This will keep the value intact even if it has a colon in it.
  def pretty_value(value)
    value_sections = value.split(':').count - 1
    pretty_value = value.split(':')[1..value_sections].join(':')
    return pretty_value
  end
end
