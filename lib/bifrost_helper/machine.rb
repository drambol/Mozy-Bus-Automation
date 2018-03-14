module BifrostHelper
  class Machine
    include BifrostHelper::Utils
    attr_accessor :auth
    def initialize(api_key)
      @api_key = api_key
      @auth = get_auth(api_key)
      @base_url = BASE_URL
      @add_url = 'accounts/containers'
      @get_put_delete_url = 'accounts/machine/'
      @begin_time = Time.now
    end

    def header
      @header = {'Authorization' => @auth, 'Content-Type' => 'application/json', 'Accept' => VERSION}
    end

    # Public: Add a machine to a user
    #
    # body - the body to post to create a machine, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #      - user_id is required
    #
    # Example
    #  machine = BifrostHelper::Machine.new(api_key)
    #  machine.add('user_id' => 3241234432, 'alias' => 'TestMachine')
    #
    # Returns machine_id
    def add(body)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      #body['alias'] = body['alias'] || 'MachineName'
      #key_string = get_keystring(auth)
      #body['keystring'] = get_keystring(auth)
      #body['keystring'] = 'DV4BSDG44D8TQAD97A3D'
      Log.debug "==============================="
      Log.debug "#{@base_url}#{@add_url}"
      Log.debug body.to_json
      Log.debug header
      Log.debug "==============================="
      machine = RestClient.post "#{@base_url}#{@add_url}", body.to_json, header
      Log.debug('add 1 machine')
      machine_id = JSON.parse(machine.body)['items'][0]['data']['id']
    end

    # Public: Get the detail of a machine
    #
    # machine_id - please refer to https://trac.dechocorp.com/wiki/Bifrost
    #
    # Example
    #  machine = BifrostHelper::Machine.new(api_key)
    #  machine.get(2323423)
    #  # => { "api":"accounts", "rsrc":"machine", "total":1, "items":[{"data": {"alias":"joseph's machine",...
    #
    # Returns Hash
    def get(machine_id)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      machine = RestClient.get "#{@base_url}#{@get_put_delete_url}#{machine_id}", header
      JSON.parse(machine.body)
    end

    # Public: Delete a machine
    #
    # machine_id - the machine to be deleted, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #
    # Example
    #  machine = Machine.new(api_key)
    #  machine.delete(19796768)
    #  # => '1'
    #
    # Returns '1'
    def delete(machine_id)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      machine = RestClient.delete "#{@base_url}#{@get_put_delete_url}#{machine_id}", header
    end
  end
end