module Controller
  require_relative 'setup'
  include Setup

  require_relative 'cucumber_runner'
  include CucumberRunner

  require_relative 'hosts_changer'
  include HostsChanger

  require_relative 'other_helpers'
  include OtherHelpers

  require_relative 'emailer'
  include Emailer
end
