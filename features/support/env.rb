require "#{File.dirname(__FILE__)}/../../test_sites/test_sites"
require "aria_sdk"

def firefox_profile
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.folderList'] = 2
  profile['browser.download.dir'] = FileHelper.ff_download_path
  profile['browser.download.downloadDir'] = FileHelper.ff_download_path
  profile['browser.download.lastDir'] = FileHelper.ff_download_path
  profile['browser.download.manager.showWhenStarting'] = false
  profile['browser.download.manager.closeWhenDone'] = true
  profile['browser.startup.homepage_override.mstone'] = 'ignore'
  profile['browser.helperApps.neverAsk.saveToDisk'] = "text/plain;application/csv;text/csv;application/vnd.ms-excel;application/octet-stream;application/x-msdos-program;application/x-apple-diskimage;application/x-debian-package;application/x-redhat-package-manager;image/png"
  profile.assume_untrusted_certificate_issuer = false
  profile.add_extension("#{FileHelper.default_test_data_path}/hostadmin-1.4.9.2-fx.xpi")
  profile.add_extension("#{FileHelper.default_test_data_path}/empty_cache_button-2.7-fx.xpi")
  #profile.native_events = true
  profile
end

Capybara.register_driver :firefox do |app|
 Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => firefox_profile)
end

Capybara.register_driver :firefox_profile do |app|
  profile_address = "#{FileHelper.default_test_data_path}/#{CONFIGS['global']['profile_name']}"
  profile = Selenium::WebDriver::Firefox::Profile.new profile_address
  profile.add_extension("#{FileHelper.default_test_data_path}/autoauth-2.1-fx+fn.xpi")
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

Capybara.register_driver :firefox_debug do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.add_extension("#{FileHelper.default_test_data_path}/firebug-2.0.9-fx.xpi")
  profile['browser.startup.homepage_override.mstone'] = 'ignore'
  profile["extensions.firebug.console.enableSites"] = true
  profile["extensions.firebug.net.enableSites"]     = true
  profile["extensions.firebug.script.enableSites"]  = true
  profile["extensions.firebug.cookies.enableSites"]  = true
  profile["extensions.firebug.allPagesActivation"]  = "on"
  profile["extensions.firebug.currentVersion"]      = "2.0.9"
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

def chrome_prefs
  prefs = {
      :download => {
          :prompt_for_download => false,
          :default_directory => FileHelper.ff_download_path
      }
  }
  prefs
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :prefs => chrome_prefs)
end

Capybara.register_driver :ie do |app|
  Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
end

Capybara.register_driver :webkit do |app|
  options = {
    timeout: CONFIGS['global']['default_wait_time'],
    ignore_ssl_errors: true
  }
  Capybara::Driver::Webkit.new(app, options)
end

Capybara.register_driver :remote_browser  do |app|
  url = 'http://127.0.0.1:4444/wd/hub'
  case BROWSER
    when "remote_firefox"
      capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => firefox_profile)
    when "remote_chrome"
          capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => {:prefs => chrome_prefs})
    when "remote_ie"
      capabilities = Selenium::WebDriver::Remote::Capabilities.internet_explorer
  end

  Capybara::Selenium::Driver.new(app, :browser => :remote, :url => url,
                                 :desired_capabilities => capabilities)
end

case BROWSER
  when "firefox"
    Capybara.default_driver = :firefox
  when "firefox_profile"
    Capybara.default_driver = :firefox_profile
  when "chrome"
    Capybara.default_driver = :chrome
  when "ie"
    Capybara.default_driver = :ie
  when "webkit"
    Capybara.default_driver = :webkit
  when "firefox_debug"
    Capybara.default_driver = :firefox_debug
  when "remote_firefox"
    Capybara.default_driver = :remote_browser
  when "remote_chrome"
    Capybara.default_driver = :remote_browser
  when "remote_ie"
    Capybara.default_driver = :remote_browser
  else
    raise "Unknown browser, please check env variable br"
end

Capybara.default_wait_time = CONFIGS['global']['default_wait_time']

# Setup Aria API
AriaApi::Configuration.auth_key = ARIA_API_ENV['auth_key']
AriaApi::Configuration.client_no = ARIA_API_ENV['client_no']
AriaApi::Configuration.url = ARIA_API_ENV['url']

# Setup Aria REST API through aria_sdk
Aria_SDK = AriaCoreRestClient.new(ARIA_API_ENV['client_no'], ARIA_API_ENV['auth_key'], TEST_ENV == "prod")

if TEST_ENV == 'prod'
  if PROD_CONFIRM == 'true'
    puts "Auto continue"
  else
    puts "Are you sure to execute on \033[31m#{TEST_ENV}  \033[37m? (Yes/No)"
    answer = STDIN.gets.chomp
    puts "answer is " + answer
    if 'Yes'.casecmp(answer).zero?
      puts "Manual continue"
    else
      exit(1)
    end
  end

end


QA_ENV['is_first_launch'] = true