module BifrostHelper
  def self.echo
    puts 'bifrost_helper!'
  end

  # Public: Add a user machine mapping
  #
  # api_key - the api_key, please refer to https://trac.dechocorp.com/wiki/Bifrost
  # user_name
  # machine_name
  #
  # Example
  #  BifrostHelper.add_user_machine_mapping_by_bifrost('FSFS534HG', 'user@user.com', 'TestMachine')
  #  # => 32545443
  #
  # Returns machine_id
  def self.add_user_machine_mapping_by_bifrost(api_key, user_name = nil, machine_name = nil, machine_type = 'Desktop')
    index = Time.now.to_i
    user_name = user_name || "test#{index}@test.com"
    machine_name = machine_name || "testmachine#{index}"
    name = "test#{index}"
    user = BifrostHelper::User.new(api_key)
    user_id = user.add('username' => user_name, 'name' => name)
    machine = BifrostHelper::Machine.new(api_key)
    machine.add('user_id' => user_id, 'alias' => machine_name, 'type' => machine_type)
  end

  # Public: Get the machine mapping num
  #
  # api_key - the api_key, please refer to https://trac.dechocorp.com/wiki/Bifrost
  #
  # Example
  #  BifrostHelper.get_mapping_num_by_bifrost('FSFS534HG')
  #  # => 5
  #
  # Returns mapping number
  def self.get_mapping_num_by_bifrost(api_key)
    user = BifrostHelper::User.new(api_key)
    r = user.get('deleted=false')
    r['total']
  end

  # Public: Remove the machine mapping
  #
  # api_key - the api_key, please refer to https://trac.dechocorp.com/wiki/Bifrost
  # user_name
  #
  # Example
  #  BifrostHelper.remove_user_machine_mapping_by_bifrost(api_key, 'user@user.com')
  #  # => '1'
  #
  # Returns '1'
  def self.remove_user_machine_mapping_by_bifrost(api_key, user_name = nil)
    del_user = user_name
    user = BifrostHelper::User.new(api_key)
    unless user_name
      del_user = user.get('deleted=false')['items'][0]['data']['username']
    end
    user.remove(del_user)
  end

  # Public: Remove the machine mapping
  #
  # api_key - the api_key, please refer to https://trac.dechocorp.com/wiki/Bifrost
  # user_name
  #
  # Example
  #  BifrostHelper.remove_user_machine_mapping_by_bifrost(api_key, 'user@user.com')
  #  # => '1'
  #
  # Returns '1'
  def self.add_subpartner_by_bifrost(api_key, body)
    subpartner = BifrostHelper::Subpartner.new(api_key)
    subpartner.add(body)
  end

  # Public: Get the default group_id
  #
  # api_key - the api_key, please refer to https://trac.dechocorp.com/wiki/Bifrost
  # partner_id
  #
  # Example
  #  BifrostHelper.get_default_group_id(api_key, 124252453)
  #  # => 3224234
  #
  # Returns default_group_id
  def self.get_default_group_id(api_key, partner_id)
    partner = BifrostHelper::Subpartner.new(api_key)
    res = partner.get(partner_id)
    res['items'][0]['data']['default_user_group_id']
  end

end