Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }

class CmsSite
  def content_pages
    CMS::ContentPages.new

  end
end
