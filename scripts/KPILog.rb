#! /usr/bin/env ruby

require 'json'
require 'time'
require 'net/https'
#require 'base64'
require 'getoptlong'
require 'net/scp'

opt = GetoptLong.new(
    [ "--help",           "-h", GetoptLong::NO_ARGUMENT       ],
    [ "--job_name",       "-n", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--build_id",       "-i", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--bus",            "-b", GetoptLong::REQUIRED_ARGUMENT],
    [ "--slave_node",     "-s", GetoptLong::OPTIONAL_ARGUMENT],
)

opt.each do |opt, arg|
  case opt
    when "--help"
      puts <<-EOF
usage
  `ruby scripts/KPILog.rb -n "BUS_Nightly_Smoke" -i 2`
  `ruby scripts/KPILog.rb -n "BUS_Nightly_Smoke" -i 2 -s "jts-appsqa-win7ultimate-64-automation7.tools.mozyops.com"`
  `ruby scripts/KPILog.rb -n "BUS_Nightly_Smoke" -i 2 -s "jts-appsqa-win7ultimate-64-automation7.tools.mozyops.com" -b "qa6_busclient04"`
      EOF
      help = true
      break
    when '--job_name'
      ENV["job_name"] = arg
    when '--build_id'
      ENV["build_id"] = arg
    when '--bus'
      ENV["bus"] = arg
    when '--slave_node'
      ENV["jenkins_slave_node"] = arg
  end
end


#Go through each file under directory, and extract the data for ELK
def parse_log(path)

  hash = Hash.new
  file = File.open(path)

  hash["env"] = ENV["bus"]
  hash["id"] = ENV["Test Case ID"]
  hash["hostname"] = ENV["jenkins_slave_node"]
  hash["result"] = "SUCCESS"

  file.each do |line|
    if line.include?("Scenario:") == true
      hash["testcase"] = line.split("Scenario:")[1].strip
    end
    if line.include?(":KPI-")==true
      hash["id"] = ENV["Test Case ID"]

      hash["name"] = "BUS " + line.match(/KPI-.*:start_time/).to_s.gsub('KPI-', '').gsub!(':start_time', '')
      hash["start_time"] = DateTime.parse(line.match(/start_time:.*\//).to_s.gsub!('start_time:', '').gsub!('/', ''))
      hash["end_time"] = DateTime.parse(line.match(/\/.*=/).to_s.gsub!('end_time:', '').gsub!('=', '').gsub!('/', ''))
      hash["es_type"] = "kpi"
      if hash["start_time"] == 0 || hash["start_time"].to_s.length < 1 || hash["end_time"] == 0 || hash["end_time"].to_s.length < 1
        hash["result"] = "FAIL"
      end
      @jsonfile.puts hash.to_json
    end
  end
end

#=============logic code============
# create new json file
jsonFile_timestamp = Time.now.utc
jsonFile_suffix = jsonFile_timestamp.to_s.gsub!(" ", "_").gsub!(":", "-")

ELK_result_file_path = "logs/results_#{jsonFile_suffix}.json"
@jsonfile = File.new(ELK_result_file_path, "w")

# get all *.log under logs directory
files = Dir.entries('logs')

# parse each log file and input the info into the .json file.
files.each do |file|
  ENV["Test Suite Name"] = "#{file.split(".")[0]}.feature"
  ENV["Test Case ID"] = file.split(".")[1]
  path = 'logs/' + file if (file.include?(".log") && !file.include?("bus_smoke_test_cleanup"))
  parse_log(path) unless path.nil?
end

# close the file streaming
@jsonfile.close

remote_path = "/var/log/fbLogKPI/"
Net::SCP.start("10.29.103.190", "mozy", :password => "mozy", :host_key => "ssh-rsa") do |scp|
  scp.upload(ELK_result_file_path, remote_path)
  puts "Done"
end
