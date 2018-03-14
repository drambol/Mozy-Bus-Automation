Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }

class OtherSites
  def migration_page
    Migration::MigrationSite.new
  end

  def cybersource_page
    CyberSource::CyberSourceBillingFillOut.new
  end

end
