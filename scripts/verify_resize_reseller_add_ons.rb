#!/usr/bin/env ruby
require 'optparse'
require '../lib/aria_api/lib/aria_api'
require '../lib/configs/configs_helper'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: ruby verify_reszie_reseller_add_ons.rb [options]"

  opts.on("-e", "--environment Aria API", "Set up Aria API, using aria_api_qa or aria_api_production") do |env|
    options[:environment] = env
  end

  opts.on("-i", "--id_list Aria id list", "Comma separated list of aria ids, e.g. 12345,67890") do |ids|
    options[:id_list] = ids
  end

  opts.on_tail( '-h', '--help', 'Display Help' ) do
    puts opts
    exit
  end
end

begin
  optparse.parse!
  mandatory = [:environment, :id_list]                             # Enforce the presence of
  missing = mandatory.select{ |param| options[param].nil? }        # the -t and -f switches
  unless missing.empty?                                            #
    puts "Missing options: #{missing.join(', ')}"                  #
    puts optparse                                                  #
    exit                                                           #
  end                                                              #
rescue OptionParser::InvalidOption, OptionParser::MissingArgument  #
  puts $!.to_s                                                     # Friendly output when parsing fails
  puts optparse                                                    #
  exit                                                             #
end

aria_ids = options[:id_list].split(',').map(&:to_i).delete_if{ |i| i<=0}

# Setup ARIA API ENV
API = ALL_ENV[options[:environment]]
AriaApi::Configuration.auth_key = API['auth_key']
AriaApi::Configuration.client_no = API['client_no']
AriaApi::Configuration.url = API['url']

def log_info(msg)
  str = Time.now.to_s + " INFO  >> " + msg
  $stdout.puts str
end

def log_error(msg)
  str = Time.now.to_s + " ERROR >> " + msg
  $stdout.puts str
end

def gold_reseller?(plans)
  plans['acct_plans'].map{ |plan| plan['plan_name'] =~ /Gold/}.compact.size > 0
end

def platinum_reseller?(plans)
  plans['acct_plans'].map{ |plan| plan['plan_name'] =~ /Platinum/}.compact.size > 0
end

success=0
failure=0

log_info("Total: #{aria_ids.size}")
aria_ids.each do |aria_id|
  begin
    log_info("Aria id: #{aria_id}")
    plans = AriaApi.get_acct_plans({:acct_no=> aria_id})
    if plans['error_msg'].eql?('OK')
      add_on_20_gb = plans['acct_plans'].select{ |plan| plan['plan_name'] =~ /20 GB add-on/ }.first
      units_20_gb =  add_on_20_gb['plan_units'].to_i
      status_20_gb = add_on_20_gb['supp_plan_status_label']
      log_info("20 GB add-on units: #{units_20_gb} >> Status: #{status_20_gb}")

    if gold_reseller?(plans)
        add_on_50_gb = plans['acct_plans'].select{ |plan| plan['plan_name'] =~ /50 GB add-on/ }.first
        units_50_gb =  add_on_50_gb['plan_units'].to_i
        status_50_gb = add_on_50_gb['supp_plan_status_label']
        log_info("50 GB add-on units: #{units_50_gb} >> Status: #{status_50_gb}")

        if units_50_gb%2 == 0
          result = (units_20_gb*20 == units_50_gb*50)
        else
          result = (units_20_gb*20 == units_50_gb*50 + 10)
        end

        if result
          if status_20_gb.eql?('Active') && status_50_gb.eql?('Terminated')
            log_info("Resize Successful")
            success += 1
          else
            raise('50 GB add-on plan is not terminated or 20 GB add-on plan is not active')
          end
        else
          raise("")
        end
      elsif platinum_reseller?(plans)
        add_on_100_gb = plans['acct_plans'].select{ |plan| plan['plan_name'] =~ /100 GB add-on/ }.first
        units_100_gb =  add_on_100_gb['plan_units'].to_i
        status_100_gb =  add_on_100_gb['supp_plan_status_label']
        log_info("100 GB add-on units: #{units_100_gb} >> Status: #{status_100_gb}")

        result = (units_20_gb*20 == units_100_gb*100)
        if result
          if status_20_gb.eql?('Active') && status_100_gb.eql?('Terminated')
            log_info("Resize Successful")
          else
            raise('100 GB add-on plan is not terminated or 20 GB add-on plan is not active')
          end
        else
          raise("Resize Failed")
        end
      else
        raise('Unknown reseller type')
      end
    else
      raise(plans['error_code'])
    end
  rescue
    failure += 1
    log_error("Aria id:#{aria_id} >> exceptions: #{$!}")
  end
end

log_info("Resize Successful: #{success} >> Resize Failed: #{failure}")

