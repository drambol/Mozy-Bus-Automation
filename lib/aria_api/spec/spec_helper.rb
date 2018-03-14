require "aria_api"
require "vcr"

VCR.configure do |c|
  current_dir = File.dirname(__FILE__)
  c.cassette_library_dir = "#{current_dir}/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end


module SupportSpecHelper
  def self.use_development_credentials
    AriaApi::Configuration.auth_key = "8Vn848nuRPa58jht9jBBpWvSUVsn3fnB"
    AriaApi::Configuration.client_no = "4950701"
    AriaApi::Configuration.url = "https://secure.future.stage.ariasystems.net/api/ws/api_ws_class_dispatcher.php"
  end

  def api
    AriaApi
  end
end

RSpec.configure do |c|
  c.include SupportSpecHelper
  # so we can use `:vcr` rather than `:vcr => true`;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

SupportSpecHelper.use_development_credentials
