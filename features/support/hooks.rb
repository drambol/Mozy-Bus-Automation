require 'os'
require 'base64'

Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
  @start_time = Time.now
end

def testcase_id(scenario)
  caseId = ''
  scenario.source_tag_names.each { |name|
    if name.length > 2 && name[1..2].downcase.eql?('tc')
      caseId = name[4..name.length]
      break
    end
  }
  caseId
end


#create log file based on scenario name, code location and case id
Before do |scenario|
  lIndex = scenario.location.file.rindex '\\'
  lIndex = scenario.location.file.rindex '/' if lIndex.nil?
  lIndex = -1 if lIndex.nil?
  rIndex = scenario.location.file.index '.'
  sName = scenario.location.file[lIndex+1 .. rIndex-1]

  caseId = testcase_id(scenario)

  file = File.new("logs/#{sName}.#{caseId}.line#{scenario.location.line.to_s}.log", 'w')
  file.puts "Scenario: #{scenario.name}"
  CapybaraHelper::Extension::Context.instance.log.dest = file
  #@logFile = file
  $logFile = file
  @scenario_start_time = Time.now

  @scenario_tags = scenario.source_tag_names
end

=begin
After do |scenario|
  @scenario_end_time = Time.now
  d = (@scenario_end_time - @scenario_start_time).to_i
  mm,ss = d.divmod(60)
  hh,mm = mm.divmod(60)
  dd,hh = hh.divmod(60)

  $logFile.puts("[Exception Message]-#{scenario.exception.message}") if scenario.failed?
  if scenario.failed?
    backtraceStrings = scenario.exception.backtrace
    for i in 0..backtraceStrings.size
      $logFile.puts("     " + backtraceStrings[i].to_s)
    end
  end
  $logFile.puts("====================================================================")
  $logFile.puts("[Test Case Result]:#{scenario.passed? ? "Succeed" : "Failed"}")
  $logFile.puts("[Test Case Start Time]:#{@scenario_start_time.to_s}")
  $logFile.puts("[Test Case End Time]:#{@scenario_end_time.to_s}")
  $logFile.puts("[Test Case Execution Time]:%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss])
  $logFile.puts("[Test Case Elapsed]:#{d}s")
  #@logFile.close
  $logFile.close
  CapybaraHelper::Extension::Context.instance.log.dest = nil
end
=end

=begin
Before('@chrome') do
  Capybara.current_driver = :chrome
end

Before('@firefox') do
  Capybara.current_driver = :firefox
end

Before('@ie') do
  Capybara.current_driver = :ie
end

Before('@webkit') do
  Capybara.current_driver = :webkit
end

Before('@firefox_profile') do
  Capybara.current_driver = :firefox_profile
end
=end

After do |scenario|
  test_plan = 656130  # "BUS Ruby on Rails upgrade"
  build_id = 6950 # "2.26.1.3-trusty1" for ruby 1.9.3 and os upgrade
  project_prefix = "Mozy"
  project_id = 2      # 2 - 'Mozy'
  client = TestlinkHelper::TestlinkAPIClient.new

  id = testcase_id scenario
  id = scenario.__id__ if id.nil? || id.length == 0
  tc = id.to_i
  test_case = client.run_api("getTestCase", {:testcaseexternalid => "#{project_prefix}-#{tc}"}).first

  # Combine two After scenario methods into one
  @scenario_end_time = Time.now
  d = (@scenario_end_time - @scenario_start_time).to_i
  mm,ss = d.divmod(60)
  hh,mm = mm.divmod(60)
  dd,hh = hh.divmod(60)

  $logFile.puts("[Exception Message]:#{scenario.exception.message}") if scenario.failed?
  if scenario.failed?
    backtraceStrings = scenario.exception.backtrace
    for i in 0..backtraceStrings.size
      $logFile.puts("     " + backtraceStrings[i].to_s)
    end

    #Dismiss alert dialog if it exists to prevent Selenium::WebDriver::Error::UnhandledAlertError from happening in all the following scenarios
    begin
      Log.debug page.driver.browser.switch_to.alert.text
      page.driver.browser.switch_to.alert.dismiss
    rescue
      Log.debug 'No alert needs to be dismissed'
    end

    name = "screenshot_TC.#{id}_line#{scenario.location.line.to_s}.png"
    #page.driver.browser.save_screenshot("html-report/#{name}")
    encoded_img =  page.driver.browser.screenshot_as(:base64)
    embed("#{encoded_img}", "image/png", "#{name}")
    page.execute_script "window.onbeforeunload = function() {};"

    arg = {:status => 'f', :testcaseid => test_case["testcase_id"].to_i, :testplanid => test_plan, :buildid => build_id, :testprojectid => project_id}
  else
    arg = {:status => 'p', :testcaseid => test_case["testcase_id"].to_i, :testplanid => test_plan, :buildid => build_id, :testprojectid => project_id}
  end

  result = client.run_api("reportTCResult", arg)
  Log.debug result

  $logFile.puts("====================================================================")
  $logFile.puts("[Test Case Result]:#{scenario.passed? ? "Succeed" : "Failed"}")
  $logFile.puts("[Test Case Start Time]:#{@scenario_start_time.to_s}")
  $logFile.puts("[Test Case End Time]:#{@scenario_end_time.to_s}")
  $logFile.puts("[Test Case Execution Time]:%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss])
  $logFile.puts("[Test Case Elapsed]:#{d}s")
  #@logFile.close
  $logFile.close
  CapybaraHelper::Extension::Context.instance.log.dest = nil

end
