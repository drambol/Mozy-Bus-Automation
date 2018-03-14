$:.unshift(File.dirname(__FILE__))

require 'sections/restore_options_section'
require 'sections/change_password_section'
require 'iframes/upload_iframe'
require 'sections/change_password_section'

Dir.glob("#{File.dirname(__FILE__)}/iframes/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }



class FreyjaSite

  def login_page(user)
    Freyja::LoginPage.new(user)
  end


  def main_page
    Freyja::MainPage.new
  end

  def action_panel_page
    Freyja::ActionPanelPage.new
  end

  def options_menu_page
    Freyja::OptionsMenuPage.new
  end

  def event_history_page
    Freyja::EventHistoryPanel.new
  end

  def detail_panel_page
    Freyja::DetailPanelPage.new
  end

  def preference_page
    Freyja::PreferencePage.new
  end

  def restore_queue_page
    Freyja::RestoreQueuePage.new
  end

  def search_page
    Freyja::SearchPage.new
  end

  def select_date_page
    Freyja::SelectDate.new
  end

  def product_download_page
    Freyja::ProductDownloadPage.new
  end

  def cybersource_page
    Freyja::CybersourceManinPage.new
  end

end