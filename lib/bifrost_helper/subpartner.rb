module BifrostHelper
  class Subpartner
    include BifrostHelper::Utils
    attr_accessor :auth
    def initialize(api_key)
      @api_key = api_key
      @auth = get_auth(api_key)
      @base_url = BASE_URL
      @add_url = 'accounts/partners'
      @get_post_delete_url = 'accounts/partner/'
      @begin_time = Time.now
    end

    def header
      @header = {'Authorization' => @auth, 'Content-Type' => 'application/json', 'Accept' => VERSION}
    end

    # Public: get a partner
    #
    # partner_id - the partner to be deleted, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #
    # Example
    #  partner = Subpartner.new(api_key)
    #  partner.get(19796768)
    #  # => {"api"=>"accounts", "count"=>1, "items"=>[{"data"=>{"billing_address"=>...
    #
    # Returns Hash
    def get(partner_id)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      partner = RestClient.get "#{@base_url}#{@get_post_delete_url}#{partner_id}", header
      JSON.parse(partner.body)
    end

    # Public: Add a subpartner for a partner
    #
    # body - the body to post to create a partner, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #      - username: admin's name. Required
    #      - name: partner's name. Required
    #
    # Example
    #  partner = Subpartner.new(api_key)
    #  partner.add('username' => 'test@test.com', 'name' => 'Subpartner')
    #
    # Returns partner_id
    def add(body)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      body['full_name'] ||= 'subadmin'
      body_= <<HERE
      {
          "parent_partner_id": #{body['partner_id']},
          "admin":
          {
              "username": "#{body['username']}",
              "full_name": "#{body['full_name']}",
              "external_id": "external id 1",
              "password": "Test1234",
              "language": "en"
          },
          "name": "#{body['name']}",
          "external_id": "external id 2",
          "company_type": "business",
          "pro_plan_id": #{body['pro_plan_id']},
          "phone": "123-456-7890",
          "billing_address": "123 bifrost blvd",
          "billing_city": "thorsville",
          "billing_state": "utah",
          "billing_country": "iceland",
          "billing_zip": "12345",
          "root_role_id": #{body['root_role_id']}
      }
HERE
      Log.debug body_
      partner = RestClient.post "#{@base_url}#{@add_url}", body_, header
      Log.debug('add 1 subpartner')
      partner_id = JSON.parse(partner.body)["items"][0]["data"]["id"]
    end

    # Public: Delete a subpartner or the partner itself
    #
    # partner_id - the partner to be deleted, please refer to https://trac.dechocorp.com/wiki/Bifrost
    #
    # Example
    #  partner = Subpartner.new(api_key)
    #  partner.delete(19796768)
    #  # => '1'
    #
    # Returns '1'
    def delete(partner_id)
      if expired?(@begin_time)
        @auth = get_auth(@api_key)
      end
      Log.debug("#{@base_url}#{@get_post_delete_url}#{partner_id}")
      partner = RestClient.delete "#{@base_url}#{@get_post_delete_url}#{partner_id}", header
    end

  end
end