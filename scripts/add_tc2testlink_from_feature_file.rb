require File.expand_path('../../lib/testlink_helper', __FILE__)

CLIENT = TestlinkHelper::TestlinkAPIClient.new
PROJECT_ID = 2                                    # project Mozy
AUTHOR_LOGIN = 'catherinel'                       # Test Link account
TEST_SUITE_PARENT_ID = '17'                       # parent test suite folder id in tesklink: Mozy -> BUS
TEST_STEP_EXECUTION_TYPE = 2                      # MANUAL(1), AUTOMATED(2);

# create a test suite
# @param struct $args
# @param string $args["devKey"]
# @param int    $args["testprojectid"]
# @param string $args["testsuitename"]
# @param string $args["details"]
# @param int    $args["parentid"] optional, if do not provided means test suite must be top level.
# @param int    $args["order"] optional. Order inside parent container
# @param int    $args["checkduplicatedname"] optional, default true, will check if there are siblings with same name.
# @param int    $args["actiononduplicatedname"] optional applicable only if $args["checkduplicatedname"]=true, what to do if already a sibling exists with same name.
# return mixed $resultInfo
def create_test_suite(test_suite_name, details)
  arg = {
      :testprojectid => PROJECT_ID,
      :testsuitename => test_suite_name,
      :details => details,
      :parentid => TEST_SUITE_PARENT_ID,
      :order => 1,
      #:checkduplicatedname => testsuite_info['name'],
      #:actiononduplicatedname => testsuite_info['author_login'],
  }
  CLIENT.run_api("createTestSuite", arg)
end

# createTestCase
# @param struct $args
# @param string $args["devKey"]
# @param string $args["testcasename"]
# @param int    $args["testsuiteid"]: test case parent test suite id
# @param int    $args["testprojectid"]: test case parent test suite id
# @param string $args["authorlogin"]: to set test case author
# @param string $args["summary"]
# @param string $args["steps"]
# @param string $args["preconditions"] - optional
# @param string $args["importance"] - optional - see const.inc.php for domain
# @param string $args["execution"] - optional - see ... for domain
# @param string $args["order'] - optional if 1, then will not add in the top
# @param string $args["internalid"] - optional - do not use
# @param string $args["checkduplicatedname"] - optional
# @param string $args["actiononduplicatedname"] - optional
# @return mixed $resultInfo
def create_test_case(testcase_info, testsuite_id)
  arg = {
      :testprojectid => PROJECT_ID,
      :order => 1,
      :testsuiteid => testsuite_id,
      :summary => testcase_info[:summary],
      :steps => testcase_info[:steps],
      :preconditions => testcase_info[:preconditions],
      :testcasename => testcase_info[:name],
      :authorlogin => AUTHOR_LOGIN,
  }
  CLIENT.run_api("createTestCase", arg)
end

# createTestCaseSteps
# @param struct $args
# @param string $args["devKey"]
# @param string $args["testcaseexternalid"] optional if you provide $args["testcaseid"]
# @param string $args["testcaseid"] optional if you provide $args["testcaseexternalid"]
# @param string $args["version"] - optional if not provided LAST ACTIVE version will be used, if all versions are INACTIVE, then latest version will be used.
# @param string $args["action"] possible values:'create','update','push'
#           create: if step exist NOTHING WILL BE DONE
#           update: if step DOES NOT EXIST will be created else will be updated.
#           push: shift down all steps with step number >= step number providedand use provided data to create step number requested. NOT IMPLEMENTED YET
# @param array  $args["steps"]: each element is a hash with following keys: step_number,actions,expected_results,execution_type
#           execution_type: Int, MANUAL(1), AUTOMATED(2);
# @return mixed $resultInfo
def create_test_step(steps, testcase_id)
  arg = {
      :testcaseid => testcase_id,
      :action => 'create',
      :steps => steps,
  }
  CLIENT.run_api("createTestCaseSteps", arg)
end

# get suite name from feature file name e.g 'features/phoenix/add_new_user.feature1' then the suite name would be 'Add New User'
def get_suite_name_feature_file(file_name)
  file_name = file_name.strip
  file_name = File.dirname(__FILE__) + "/.././" + file_name
  suite_name = ''
  if File.exist?(file_name) && file_name.include?('.feature')
    index = file_name.rindex('/') + 1
    suite_name_array = file_name[index..(file_name.length-9)].split('_')
    suite_name_array_new = suite_name_array.map{|a| a.capitalize}
    suite_name = suite_name_array_new.join(' ')
  end
  puts "Suite name is #{suite_name}"
  suite_name
end

def get_test_cases_from_feature(file_name)
  test_case_arr = [];
  string_flag = false
  data_flag = false
  test_case_single_arr = Array.new
  str = ''
  data_str = ''

  file_name = File.dirname(__FILE__) + "/.././" + file_name
  if !(File.exist?(file_name))
    puts "###########################"
    puts "Can't find scenario file #{file_name}"
    puts "###########################"
    return test_case_arr
  end

  File.open(file_name, 'r') do |file|
    file.each_line do |line|
      line_info_arr = get_line_info_from_scenario(line)
      if string_flag
        str << line_info_arr[1] unless line_info_arr[0]=='data'  ## add string content to the array
      end
      if data_flag
        data_flag = false unless line_info_arr[0]=='data'
        if !data_flag
          test_case_single_arr << data_str
          data_str = ''
        end
      end
      if line_info_arr[0] == 'name'
        string_flag = false
        test_case_single_arr = []
        test_case_arr.push(test_case_single_arr)
        test_case_single_arr.push(line_info_arr[1])
      elsif line_info_arr[0] == 'step'
        string_flag = false
        test_case_single_arr << line_info_arr[1]
      elsif line_info_arr[0] == 'data'
        data_flag = true
        data_str << line + "</br>"
      elsif line_info_arr[0] == 'string'
        string_flag = !string_flag
        str << line_info_arr[1]
        unless string_flag        # add the whole string to the array
          test_case_single_arr << str
          str = ''
        end
      end
    end
    test_case_single_arr << data_str if data_flag
  end
  test_case_arr
end

# decide the type of a line data from feature file
def get_line_info_from_scenario(str)
  line_info_arr = ['','']
  str = str.strip
  result = ''
  if str.match(/^(Scenario:)s*/).nil? == false        # start with Scenario, it would be test case name
    str = str.gsub(/^(Scenario: TC.)\s?\d*/, '').strip
    result = str.gsub(/^(Scenario:)\s?\d*/, '').strip
    line_info_arr[0] = 'name'
  elsif str.match(/^(When |Then |But |And |Given )s*/).nil? == false   # steps actions
    result = str.gsub(/^(When |Then |But |And |Given )/, '').strip
    line_info_arr[0] = 'step'
  elsif str.match(/^\|.*\|$/).nil? == false
    line_info_arr[0] = 'data'
    result = str
  elsif str.match(/^@.*/).nil? == false        # not be used for now for tag
    line_info_arr[0] = 'tag'
    result = str
  elsif str=='"""'
    line_info_arr[0] = 'string'
    result = str
  else
    line_info_arr[0] = 'TBD'
    result = str
  end
  line_info_arr[1] = result
  line_info_arr
end

# re-organize test cases array, make sure the data section is combined with the step definition
def reorganize_test_cases(test_cases_arr)
  i = 1
  while i < test_cases_arr.size
    if test_cases_arr[i].strip.start_with?("|")
      test_cases_arr[i-1] = test_cases_arr[i-1] + "</br>" + test_cases_arr[i].gsub(' ', '&nbsp;')
      test_cases_arr[i] = ''
    end
    i = i + 1
  end
  test_cases_arr_new = test_cases_arr.reject {|testcase|
    testcase.size == 0
  }
  test_cases_arr_new
end


def add_test_cases_into_testlink(file_name)
  # get test suite name according to feature file name
  suite_name = get_suite_name_feature_file(file_name)
  if suite_name == ''
    puts "##################"
    puts "Can't find file #{file_name} or it's not a feature file"
    return
  end

  # get test cases array from feature file
  test_cases_arr = get_test_cases_from_feature(file_name)
  if test_cases_arr.size == 0
    puts "##################"
    puts "Can't get any test cases information from file #{file_name}"
    return
  end

  # create test suite
  create_suite_result = create_test_suite(suite_name, suite_name)
  puts create_suite_result
  if create_suite_result.class == Array
    test_suite_id = create_suite_result[0]['id']
  else
    test_suite_id = create_suite_result['id']
  end
  puts "Test suite id is #{test_suite_id}"
  if test_suite_id == 0
    puts "##################"
    puts "Failed to create test suite for file #{file_name}, " + create_suite_result['msg']
    return
  end

  # create test cases one by one
  test_cases_arr.each do |testcase|
    i = 1
    steps = []
    # each testcase is an array, the first data is test case name and other data is the steps
    testcase = reorganize_test_cases(testcase)
    # generate step array data, expected_results is always blank
    while i < testcase.size
      steps << {:step_number => i,:actions => testcase[i],:expected_results => '',:execution_type => TEST_STEP_EXECUTION_TYPE}
      i = i + 1
    end
    # test case summary is the same as test case name
    create_case_result = create_test_case({:summary => testcase[0],:steps => steps,:preconditions => '',:name => testcase[0]}, test_suite_id)
    puts create_case_result
    if create_case_result.class == Array
      # test_case_id = create_suite_result[0]['id']  get test case id
      test_case_add_info = create_suite_result[0]['additionalInfo']
      puts test_case_add_info
    end
    #create_step_result = create_test_step(steps, test_case_id)
    #puts create_step_result
  end
end

# execute example
# add_test_cases_into_testlink('/features/phoenix/change_current_plan_fr_vat.feature')