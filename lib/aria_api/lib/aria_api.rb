require "httparty"
require "json"
require "savon"
require "#{File.dirname(__FILE__)}/aria_api/exceptions"
require "#{File.dirname(__FILE__)}/aria_api/configuration"
require "#{File.dirname(__FILE__)}/aria_api/service"

module AriaApi
  include HTTParty

  def self.make_request(opts={})
    opts = serialize_opts request_defaults.merge(opts)
    serialize_response post(AriaApi::Configuration.url, :body => opts)
  end

  def self.serialize_opts(opts)
    opts.each { |k, v| opts[k] = v.join("|") if v.is_a?(Array) }
  end

  def self.request_defaults
    { :output_format => "json" }.merge AriaApi::Configuration.credentials
  end

  def self.serialize_response(response)
    response.each do |k, v|
      response[k] = v.split("|") if v.is_a?(String) && v.match(/\|/)
    end
  end

  class << self
    AriaApi::Service.actions.each do |call_name|
      # Poor-man's default block arguments for 1.8.7 with *args.
      define_method(call_name) do |*args|
        opts = args[0] || {}
        params = { :rest_call => call_name }.merge(opts)
        make_request params
      end
    end
  end
end
