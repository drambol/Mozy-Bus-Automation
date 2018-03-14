module HostsChanger

  def valid_environment?(env)
    return true if $env.key?(env)
    false
  end

  def list_environments
    str =  "Avaliable environments are:\n"
    $env.each{|k| str += "#{k[0]} "}
    str
  end

  def change_environment(input)
    unless $env.key?(input)
      puts "'#{input}' is not a valid environment"
      list_environments
      abort
    end
    return puts "Already using environment: #{input}" unless different_environment?($env[input])
    puts "This should change the environment to '#{input}'"

    str = edit_hosts(read_hosts)
    str += set_evironment_str(input,$env)
    write_hosts(str)
  end

  def get_current_environment(site)
    case site
    when 'bus'; ip = get_ip('mozypro.com')
    when 'phx'; ip = get_ip('secure.mozy.com')
    end

    $env.each do |a,b|
      next if b==nil
      return a if ip == b[site]
    end
    return 'prod'
  end

  def set_evironment_str(input,env)
    return '' if input == 'prod'
    cms = 'mozy.com www.mozy.com mozy-us.com www.mozy-us.com'
    euc = 'mozy.co.uk www.mozy.co.uk mozy.fr www.mozy.fr mozy.ie www.mozy.ie mozy.de www.mozy.de'
    phx = 'secure.mozy.com secure.mozy.co.uk secure.mozy.fr secure.mozy.ie secure.mozy.de'
    bus = 'mozypro.com www.mozypro.com europe.mozypro.com home.mozypro.com secure.mozypro.com'
    rbw = 'rainbow.mozy.com'

    env_string = "\n\n#{$recognizer}##{input}\n"
    env = env[input]
    unless env == nil #Cover for production
      env.each do |k,v|
        env_string += "#{v} #{cms} \n" if k == 'cms'
        env_string += "#{v} #{euc} \n" if k == 'euc'
        env_string += "#{v} #{phx} \n" if k == 'phx'
        env_string += "#{v} #{bus} \n" if k == 'bus'
        env_string += "#{v} #{rbw} \n" if k == 'rbw'
      end
    end
    env_string += $recognizer
  end

  def read_hosts
    @host_path = $windows ? 'C:\windows\System32\drivers\etc\hosts' : '/etc/hosts'
    File.open(@host_path,'r') {|f| f.read}
  end

  def edit_hosts(str)
    return_str,past_automation = '', false
    str.each_line do |line|
      if line == $recognizer
        past_automation ^= true #toggles boolean
        next
      end
      next if past_automation
      line = "##{line}" if ((line.include? 'mozy') && (line[0] != '#'))
      return_str += line
    end
    return_str = return_str.split("\n").join("\n") #remove trailing spaces
    return_str
  end

  def write_hosts(str)
    cmd = "echo \"#{str}\" > #{@host_path}"
    run_as_admin(cmd)
  end

  def run_as_admin(cmd)
    if $windows
      #TODO fix windows
      cmd = cmd.gsub(/"/,/'/)
      run = "runas /noprofile /user:#{`whoami`.chomp} \"cmd /C #{cmd}\""
    else
      run =  "sudo #{cmd}"
    end
    system(run)
  end

  def get_ip(webpage)
    ip = $windows ? `ping -n 1 #{webpage}` : `ping -c 1 #{webpage}`
    return 'No IP' if $?.exitstatus == 68
    return ip.to_s.split('[')[1].split(']')[0] if $windows
    return ip.to_s.split(/\n/)[0].split('(')[1].split(')')[0]
  end

  def different_environment?(hash)
    return true if hash.nil?
    return true if get_ip('mozy.com')         != hash['cms'] if hash.key?('cms')
    return true if get_ip('mozy.co.uk')       != hash['euc'] if hash.key?('euc')
    return true if get_ip('secure.mozy.com')  != hash['phx'] if hash.key?('phx')
    return true if get_ip('mozypro.com')      != hash['bus'] if hash.key?('bus')
    return true if get_ip('rainbow.mozy.com') != hash['rbw'] if hash.key?('rbw')
    false
  end
end
