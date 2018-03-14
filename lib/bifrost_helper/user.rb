module BifrostHelper  class User
    include BifrostHelper::Utils
    attr_accessor :auth
    def initialize(api_key)
      @api_key = api_key
      @auth = get_auth(api_key)
      @base_url = BASE_URL
      @add_show_url = 'accounts/users'
      @update_remove_url = 'accounts/user/'
      @begin_time = Time.now
    end

    def header
      #@header = {'Authorization' => @auth, 'Content-Type' => 'application/json', 'Accept' => 'application/vnd.mozy.bifrost+json;v=1'}
      @header = {'Authorization' => @auth, 'Content-Type' => 'application/json', 'Accept' => VERSION}
    end

    # Public: Get the user details
    #
    # search - the condition
    #
    # Example
    #  user = User.new(api_key)
    #  user.get('deleted=false')
    #  # => {"api"=>"accounts", "count"=>1, "items"=>[{"data"=>{"billing_address"=>...
    #
    # Returns Hash
    def get(search = '')
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      user = RestClient.get "#{@base_url}#{@add_show_url}", header.merge({'search' => search})
      JSON.parse(user.body)
    end

    # Public: Add a user to the default group of the partner
    #
    # body - the body to post to create a user, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #      - username is required
    #
    # Example
    #  user = User.new(api_key)
    #  user.add('username' => 'test@test.com', 'alias' => 'TestUser')
    #
    # Returns user_id
    def add(body)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      #body['password'] = body['password'] || 'test123'
      #body['name'] = body['name'] || 'TestUser'
      Log.debug body
      Log.debug "#{@base_url}#{@add_show_url}"
      Log.debug body.to_json
      Log.debug header
      user = RestClient.post "#{@base_url}#{@add_show_url}", body.to_json, header
      Log.debug('add 1 user')
      user_id = JSON.parse(user.body)['items'][0]['data']['id']
      Log.debug user_id
    end

    # Public: Remove a user to the default group of the partner
    #
    # username - the user to be deleted
    #
    # Example
    #  user = User.new(api_key)
    #  user.remove('test@test.com')
    #
    # Returns boolean
    def remove(user_name)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      user_id = get_id(user_name)
      user = RestClient.delete "#{@base_url}#{@update_remove_url}#{user_id}", header
      Log.debug('remove 1 user')
      if 200 == user.code && '1' == (user.body)
        true
      else
        false
      end
    end

    # Public: Get the user-id
    #
    # user_name - the username
    #
    # Example
    #  user = User.new(api_key)
    #  user.get_id('test@test.com')
    #
    # Returns user_id
    def get_id(user_name)
      user = RestClient.get "#{@base_url}#{@add_show_url}", header.merge({'search' => "username=#{user_name}"})
      user_id = JSON.parse(user.body)['items'][0]['data']['id']
    end

  end
end