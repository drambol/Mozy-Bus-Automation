require 'fileutils'

module Utility
  def hash_to_object(hash, obj)
    hash.each do |k,v|
      obj.send("#{k}=", v)
    end
  end

  # added by leong
  def migrate_partners(start_pid, end_pid='')
    response = RestClient::Request.execute(:method => :get, :url => "#{QA_ENV['migration_url']}?starting=#{start_pid}&ending=#{end_pid}", :timeout => 120, :open_timeout => 120)

    if end_pid.empty?
      num = 1
    else
      num = end_pid.to_i - start_pid.to_i
    end

    raise 'migrate partners error' unless response.to_s.include?("#{num} partners have been successfully migrated")
  end

  def replace_hosts_file(hosts_file_name)
    src_path = "#{File.dirname(__FILE__)}/../scripts/ci/#{hosts_file_name}"
    dst_path = "C:/Windows/System32/drivers/etc/hosts"
    dst_path = "/etc/hosts" if RUBY_PLATFORM.include?('linux')

    FileUtils.cp(src_path, dst_path)
  end
end

def is_blue_green_test
  if ENV['BLUE'].nil? || ENV['GREEN'].nil?
    return false
  else
    return true
  end
end

def get_current_env
  #check the hosts file in system, return the env info in such format {'color'=>'blue', 'hosts'=>'qa12_busclient01'}
  hosts_path = "C:/Windows/System32/drivers/etc/hosts"
  hosts_path = "/etc/hosts" if RUBY_PLATFORM.include?('linux')

  f = File.open(hosts_path)
  current_hosts_file = f.readline.strip.sub('#', '')
  f.close

  if ENV['BLUE'] == current_hosts_file
    return {'color' => 'blue', 'hosts' => current_hosts_file}
  elsif ENV['GREEN'] == current_hosts_file
    return {'color' => 'green', 'hosts' => current_hosts_file}
  else
    return {'color' => nil, 'hosts' => current_hosts_file}
  end
end