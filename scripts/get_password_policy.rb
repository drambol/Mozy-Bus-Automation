#!/usr/bin/env ruby
# this script need to be scp to the script folder of bus node
# like: scp get_password_policy.rb root@busclient01.qa6.mozyops.com:/var/www/bus/script/
require 'getoptlong'
require 'rdoc/usage'

opts = GetoptLong.new(
    [ "--help",        "-h", GetoptLong::NO_ARGUMENT       ],
    [ "--environment", "-e", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--dryrun",      "-d", GetoptLong::NO_ARGUMENT       ],
    [ "--partner",     "-p", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--type",        "-t", GetoptLong::REQUIRED_ARGUMENT ]
)

environment = "production"
dry_run = false
partner_id = nil
type = nil

opts.each do |opt, arg|
  case opt
    when '--help'
      RDoc::usage('usage')
    when '--environment'
      environment = arg
    when '--dryrun'
      dry_run = true
    when '--partner'
      partner_id = Integer(arg) rescue nil
    when '--type'
      type = arg
  end
end

class DryRunException < RuntimeError; end

require File.dirname(__FILE__) + '/../config/boot'
RAILS_ENV.replace(environment) if defined?(RAILS_ENV)
require File.dirname(__FILE__) + '/../config/environment'

partner = ProPartner.find(partner_id)
if partner.nil?
  raise 'partner is not found'
end
password_policy = partner.send("#{type}_password_policy").password_policy
puts password_policy.inspect
