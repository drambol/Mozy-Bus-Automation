require 'net/https'
module SSHTDSGrowQuota

  # Public: Connect to the tds and "Dump serialized manifest from tds or something like that"
  #
  # @username [String] 'qa1+andrea+fisher+1417@decho.com'
  # @password [String] 'test1234'
  # @machine_id [String] '4903844'
  # @i [Int] '1' iteration of method
  #
  # Example
  #  SSHTDSGrowQuota.grow_quota('qa1+andrea+fisher+1417@decho.com', 'test1234', '4903844', '1')
  #
  # @return [String] "Partner 12345 is using autogrow and is overdrafted on its Generic license by 5 GB"
  def grow_quota(username, password, machine_id, i, filename = nil, upload_file = 'false', user_agent = nil)
    # if TEST_ENV.include?('qa12')
      @filename = filename.nil? ? 'upload_file.txt' : filename
      if upload_file == 'true'
        #Create a file in customized size (GB)
        @filename = 'upload_file1.txt'
        create_file (i)
      else
        #Create a 1M file to upload
        create_file (0.001) unless File.exist?("test_data/" + @filename)
      end
      file_path = File.new("test_data/" + @filename)
      file_content = File.read("test_data/" + @filename)
      Log.debug "#{QA_ENV['tds_host']}, #{username}, #{password}, #{machine_id}, #{uri_escape(file_path.to_path)}"
      url = "/namedObjects/#{machine_id}/#{uri_escape(file_path.to_path)}"
      request = Net::HTTP::Put.new(url)
      request.basic_auth(username, password)
      request["User-agent"] = user_agent || "kalypso/2.26.4.395"
      request.body = file_content
    # else
    #   encrypted_file_size = (("1073741824".to_f)*(i.to_f)).to_i.to_s
    #   object_id = "73aecc4d92453e5dacaa1eddf1df55487cfb50af"
    #   filename = "gig-ishfile#{rand(500)}#{i}.txt" if filename.nil?
    #   Log.debug "#{QA_ENV['tds_host']}, #{username}, #{password}, #{machine_id}, #{filename}, #{object_id}, #{encrypted_file_size}"
    #   url = "/namedObjects/#{machine_id}/#{uri_escape(filename)}"
    #   request = Net::HTTP::Put.new(url)
    #   request.basic_auth(username, password)
    #   request["X-Objectid"] = object_id
    #   request["X-Eventual-Content-Encoding"] = "x-ciphertext"
    #   request["X-Eventual-Content-Length"] = encrypted_file_size
    #   request["Content-Length"] = 0
    #   request["User-agent"] = user_agent unless user_agent.nil?
    # end

    http_conn = http_connect(QA_ENV['tds_host'])
    result = http_conn.start { |http| http.request(request) }
    Log.debug result
    DBHelper.update_machine_info(machine_id, i) unless upload_file == 'true'
    return result
  end

  def http_connect (host, port = 80)
    http_connection = Net::HTTP.new(host, port)
    return http_connection
  end

  def create_file (size)
    real_size = (Float(size) * 1024 * 1024 * 1024).to_i
    if OS.windows?
      delete_string = ('del ' + File.dirname(__FILE__) + '/../test_data/' + @filename).gsub!('/', '\\').to_s
      create_string = ('fsutil file createnew ' + File.dirname(__FILE__) + '/../test_data/' + @filename + ' ' + real_size.to_s).gsub!('/', '\\').to_s
    else
      delete_string = ('rm ' + File.dirname(__FILE__) + '/../test_data/' + @filename).to_s
      create_string = ('dd if=/dev/urandom of=' + File.dirname(__FILE__) + '/../test_data/' + @filename + ' bs=' + real_size.to_s+ ' count=1').to_s
    end
    system(delete_string)
    system(create_string)
  end

  def uri_escape(string)
    string.gsub(/([^a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end
  end
end



