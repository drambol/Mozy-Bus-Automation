Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }

class PhoenixSite
  def select_dom
    Phoenix::DomSelection.new
  end

  def licensing_fill_out
    Phoenix::NewPartnerLicensingFillout.new
  end

  def billing_fill_out
    Phoenix::NewPartnerBillingFillout.new
  end

  def reg_complete_pg
    Phoenix::NewRegistrationComplete.new
  end

  def account_page
    Phoenix::Account.new
  end

  def verify_email_address
    Phoenix::AccountVerification.new
  end
    
  def phoenix_acct_fill_out
    Phoenix::PhoenixCreation.new
  end

  def user_account
    Phoenix::UserAccount.new
  end

  def update_profile
    Phoenix::ChangeProfilePage.new
  end

  def invoice_page
    Phoenix::HomeInvoice.new
  end

end
