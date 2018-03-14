module Emailer

  def send_email(to_,subject_,message)
    require File.join(current_cucumber_project,'test_sites','configs','configs_helper')
    require 'gmail'

    Gmail.new(CONFIGS['gmail']['username'], CONFIGS['gmail']['password']) do |gmail|
      gmail.deliver do
        to to_
        subject subject_
        text_part do
          body message
        end
      end
    end
  end
end
