require "httparty"
module Version
  include HTTParty

  def get_version
    file = nil
    begin
      res = HTTParty.post('https://www.mozypro.com/version.txt')
      version = res.to_s
      if version.end_with?("\n")
        version = version[0, version.length-1]
      end
      file = File.new("version.#{version}", 'w')
      file.puts version
    rescue Exception => ex
      puts ex.to_s
    ensure
      file.close if !file.nil?
    end
  end

end