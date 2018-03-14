require 'tempfile'

# Extend Capybara driver class to make it inter-process safe (reduce port conflict).
class Capybara::Selenium::Driver < Capybara::Driver::Base

  alias_method :old_browser, :browser
  def browser
    File.open('parallel_tests.lock', File::RDWR|File::CREAT, 0644) {|f|
      f.flock(File::LOCK_EX)
      old_browser
    }
  end

end