$:.unshift(File.dirname(__FILE__))
require 'sections/account_overview_section'
require 'sections/supplemental_plans_section'
require 'sections/change_plan_units_section'
require 'sections/save_plan_units_section'
require 'sections/account_groups_section'
require 'sections/account_status_section'
require 'sections/form_of_payment_section'
require 'sections/notification_method_section'
require 'sections/taxpayer_section'

require 'iframes/inner_work_iframe'
require 'sections/side_menu_section'
require 'iframes/work_iframe'
require 'iframes/main_iframe'
require 'iframes/outer_iframe'

Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }


class AriaSite

  def login_page
    Aria::LoginPage.new
  end

  def admin_tools_page
    Aria::AdminToolsPage.new
  end

  def accounts_page
    Aria::AccountsPage.new
  end

end


