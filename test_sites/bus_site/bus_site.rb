Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }


class BusSite

  def login_page
    Bus::LoginPage.new
  end

  def admin_console_page
    Bus::AdminConsolePage.new
  end

  def user_login_page(subdomain, type = 'mozy')
    Bus::UserLoginPage.new(subdomain, type)
  end

  def admin_login_page(subdomain, type = 'mozy')
    Bus::UserLoginPage.new(subdomain, type, 'admin')
  end

  def user_account_page(subdomain = nil)
    Bus::UserAccountPage.new(subdomain)
  end

  def authentication_failed_page(subdomain = nil)
    Bus::AuthenticationFailedPage.new(subdomain)
  end

  def verify_email_page
    Bus::VerifyEmailPage.new
  end

  def partner_subdomain_page
    Bus::PartnerSubdomainPage.new
  end

  def partner_product_name_page
    Bus::PartnerProductNamePage.new
  end

  def branding_page
    Bus::BrandingPage.new
  end

  def adfs_login_page
    Bus::AdfsLoginPage.new
  end

  def itemized_login
    Bus::ItemizedLoginPage.new
  end

  def mysupport_page
    Bus::MySupportPage.new
  end

  def manifest_view_page
    Bus::ManifestViewPage.new
  end

  def user_pid_login_page(pid, partner_type, prefix = 'www.mozypro.com')
    Bus::UserPartnerIDLoginPage.new(pid, partner_type, prefix)
  end

  def user_login_bus_page
    Bus::UserLoginBusPage.new
  end

  def partner_invoice_page
    Bus::PartnerInvoicePage.new
  end

  def fedex_page
    Bus::FedEXPage.new
  end

  def helplink_page
    Bus::HelpLinkPage.new
  end

  def log(text)
    $logFile.puts("======[Log]:#{text}======\n")
  end
end

