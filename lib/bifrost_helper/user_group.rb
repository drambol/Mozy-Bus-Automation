module BifrostHelper
  class UserGroup
    include BifrostHelper::Utils
    attr_accessor :auth
    def initialize(api_key)
      @api_key = api_key
      @auth = get_auth(api_key)
      @base_url = BASE_URL
      @add_url = 'accounts/user_groups'
      @get_post_delete_url = 'accounts/user_group/'
      @begin_time = Time.now
    end

    def header
      @header = {'Authorization' => @auth, 'Content-Type' => 'application/json', 'Accept' => VERSION}
    end

    # Public: Get the detail of a user_group
    #
    # group_id - required, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #
    # Example
    #  user_group = BifrostHelper::UserGroup.new(api_key)
    #  user_group.get(123456)
    #  # => { "api":"accounts", "rsrc":"user_group", "total":1, "items":[{"data":...
    #
    # Returns Hash
    def get(group_id)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      Log.debug("#{@base_url}#{@get_post_delete_url}#{group_id}")
      user_group = RestClient.get "#{@base_url}#{@get_post_delete_url}#{group_id}", header
      JSON.parse(user_group.body)
    end

    # Public: Add a user group to a partner
    #
    # body - the body to post to create a group, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #      - partner_id is required
    #
    # Example
    #  user_group = BifrostHelper::UserGroup.new(api_key)
    #  user_group.add('partner_id' => 3241234432, 'name' => 'TestGroup')
    #
    # Returns user_group_id
    def add(type, body)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      if type == "MozyPro"
        body['name'] ||= 'New group'
        body =<<HERE
        {
          "name": "#{body['name']}",
          "partner_id": #{body['partner_id']}
          "enable_stash": "Yes"
        }
HERE
      else
        body['name'] ||= 'New group'
        body = <<HERE
      {
        "default_quotas": [{
        "type": "GrandFathered",
        "quota": -1
        },
        {
          "type": "Desktop",
          "quota": -1
        },
        {
          "type": "Server",
          "quota": -1
      }],
        "name": "#{body['name']}",
        "partner_id": #{body['partner_id']}
      }
HERE
      end

      Log.debug body

      user_group = RestClient.post "#{@base_url}#{@add_url}", body, header
      Log.debug('add 1 user_group')
      user_group_id = JSON.parse(user_group.body)['items'][0]['data']['id']
    end

    # Public: Delete a user_group
    #
    # group_id - required, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #
    # Example
    #  user_group = BifrostHelper::UserGroup.new(api_key)
    #  user_group.delete(123456)
    #  # => '1'
    #
    # Returns '1'
    def delete(group_id)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      Log.debug("#{@base_url}#{@get_post_delete_url}#{group_id}")
      user_group = RestClient.delete "#{@base_url}#{@get_post_delete_url}#{group_id}", header
    end

  end
end