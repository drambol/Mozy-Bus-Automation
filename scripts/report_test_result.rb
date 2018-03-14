#This script is used to read test result in lor file and report test case execution result to testlink
# This script require ruby 1.9 or above
# How to use:
# (1) use your own testlink dev key in lib/testlink_helper.rb
# (2) define your lor file path
# (3) use the specified test plan info according to test plan id, build name, project prefix

require File.expand_path('../../lib/testlink_helper', __FILE__)

LOR_FILE = File.expand_path('../../lor', __FILE__)

TEST_PLAN = 424299                           #"Bus Postgres Upgrade - Automation"
BUILD_NAME = 'bus2.15.0.9_qa12_postgres9.2'
PROJECT_PREFIX = "Mozy"                      # project Mozy
CLIENT = TestlinkHelper::TestlinkAPIClient.new

def report_result_for_testcase(testcase_externalid, result='t', testplan_id=nil, build_name=nil)
  testplan_id = "#{TEST_PLAN}".to_i || testplan_id
  buildname = "#{BUILD_NAME}" || build_name
  testcase_externalid = 'Mozy-'+testcase_externalid.to_s
  puts  "test plan: #{testplan_id}, case: #{testcase_externalid}, result: #{result}"
  arg = {:testplanid => testplan_id, :testcaseexternalid => testcase_externalid, :status => result, :buildname => buildname, :overwrite => false}
  CLIENT.run_api("reportTCResult", arg)
end

def  get_result_from_lor(file)
  result_file = File.open(file,'r')
  lines = result_file.readlines()
  return nil,nil if lines[-3].match(/31m.*failed/) == nil and lines[-3].match(/32m\d+\spassed/) == nil

  passed = []
  failed = []
  case_match = true
  failed_num = (lines[-3].match(/31m\d+\sfailed/) != nil)? lines[-3][/31m\d+\sfailed/].gsub('31m','').gsub('failed','').to_i : 0
  passed_num = (lines[-3].match(/32m\d+\spassed/) != nil)? lines[-3][/32m\d+\spassed/].gsub('32m','').gsub('passed','').to_i : 0
  lines[(-4-failed_num)..(-5)].each {|line| failed << line[/Scenario:\D*\d+/].gsub(/Scenario:\D*/,'').to_i if line.match(/Scenario:\D*\d+/) != nil} if failed_num!=0
  if passed_num !=0
    lines[0...(-5-failed_num)].each_index {|x| passed << lines[x][/36m@TC.\d+/].gsub('36m@TC.','').to_i if lines[x].match(/36m@TC.\d+/) != nil and lines[x+2].match(/32m/)!=nil}
    passed.select! {|case_id| !failed.include?(case_id)}
  end

  puts "failed num is #{failed.length}, failed case is :", failed
  puts "passed num is #{passed.length}, passed case is :", passed

  if failed_num != failed.length
    puts "failed case num is not match!"
    case_match = false
  end

  if passed_num != passed.length
    puts "passed case num is not match!"
    case_match = false
  end

  return passed, failed, case_match

end


pass_tcid, fail_tcid, case_num_correct = get_result_from_lor(LOR_FILE)

if case_num_correct
  pass_tcid.each {|tcid| puts report_result_for_testcase(testcase_externalid=tcid, result='p')}
  fail_tcid.each {|tcid| puts report_result_for_testcase(testcase_externalid=tcid, result='f')}
end


