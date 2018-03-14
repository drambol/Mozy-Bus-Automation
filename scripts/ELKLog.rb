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
  `ruby scripts/ELKLog.rb -n "BUS_Nightly_Smoke" -i 2`
  `ruby scripts/ELKLog.rb -n "BUS_Nightly_Smoke" -i 2 -s "jts-appsqa-win7ultimate-64-automation7.tools.mozyops.com"`
  `ruby scripts/ELKLog.rb -n "BUS_Nightly_Smoke" -i 2 -s "jts-appsqa-win7ultimate-64-automation7.tools.mozyops.com" -b "qa6_busclient04"`
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
  #hash["Bus Server"] = ENV["bus"]
  #hash["Jenkins Slave Node"] = ENV["jenkins_slave_node"]
  #hash["Jenkins Job Name"] = ENV["job_name"]
  #hash["Build ID"] = ENV["build_id"]
  #hash["Test Suite Name"] = ENV["Test Suite Name"]
  #hash["Test Case ID"] = ENV["Test Case ID"]
  #hash["Exception Message"] = ""

  hash["qa_environment"] = ENV["bus"]
  hash["jenkins_job_name"] = ENV["job_name"]
  hash["jenkins_job_build"] = ENV["build_id"]
  hash["feature"] = ENV["Test Suite Name"]
  hash["id"] = ENV["Test Case ID"]
  hash["error"] = ""
  hash["test_result"] = "Failed"
  hash["es_type"] = "bus_auto"

  file.each do |line|
    case line
      when if line.include?("Scenario:") == true
             #hash["Scenario"] = line.split(":")[1].strip
             hash["name"] = line.split(":")[1].strip
           end
      when if line.include?("[Test Case Result]") == true
             #hash["Test Case Result"] = line.split(":")[1].strip
             hash["test_result"] = line.split(":")[1].strip
           end
      when if line.include?("[Test Case Start Time]") == true
             #hash["Test Case Start Time"] = Time.parse(line.split(":")[1])
             hash["start_time"] = Time.parse(line.split(":")[1])
           end
      when if line.include?("[Test Case End Time]")
             #hash["Test Case End Time"] = Time.parse(line.split(":")[1])
              hash["end_time"] = Time.parse(line.split(":")[1])
           end
      #when if line.include?("[Test Case Execution Time]") == true
             #hash["Test Case Execution Time"] = line.split(":")[1].strip
           #end
      when if line.include?("[Test Case Elapsed]") == true
             #hash["Test Case Elapsed"] = line.split(":")[1].strip.gsub!("s", "").to_i
             hash["duration"] = line.split(":")[1].strip.gsub!("s", "")
           end
      when if line.include?("[Exception Message]") == true
             #hash["Exception Message"] = line.split(":")[1].strip
              hash["error"] = line.split(":")[1].strip
           end
    end

  end
  @jsonfile.puts hash.to_json
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

remote_path = "/var/log/fbLog/"
Net::SCP.start("10.29.103.190", "mozy", :password => "mozy", :host_key => "ssh-rsa") do |scp|
  scp.upload(ELK_result_file_path, remote_path)
  puts "Done"
end
