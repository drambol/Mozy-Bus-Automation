# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aria_api/version"

Gem::Specification.new do |s|
  s.name        = "aria_api"
  s.version     = AriaApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aria Systems, Inc"]
  s.email       = ["dcalpha@ariasystems.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Wrap for the aria subscriptions and billing system}
  s.description = %q{Ruby Wrap for the aria subscriptions and billing system}

  s.rubyforge_project = "aria_api"

  s.files         = `git ls-files`.split("\n").delete_if { |f| f.match /vcr_cassettes/ }
  s.test_files    = `git ls-files -- spec/*`.split("\n").delete_if { |f| f.match /vcr_cassettes/ }
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "httparty"
  s.add_dependency "json"
  s.add_dependency "savon"

  ["rake", "rspec", "vcr", "webmock"].each do |dev_dependency|
    s.add_dependency dev_dependency
  end
end
