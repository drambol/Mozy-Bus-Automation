require 'net/scp'
module SSHHelper
  PROXY_HOST = 'authproxy01.qa12h.mozyops.com'
  SOCKD_CONF = '/etc/sockd.conf'
  BUS_HOST = QA_ENV['bus_host'].gsub("https://", '')
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

  # Public: get the file from a server
  #
  def download(remote_path, local_path)
    Net::SCP.start(PROXY_HOST, USER, :password => PASSWORD, :host_key => "ssh-rsa") do |scp|
      scp.download(remote_path, local_path)
    end
  end

  def get_ssh_password_config(partner_id, type)
    Net::SSH.start(BUS_HOST, USER, :password => PASSWORD, :host_key => "ssh-rsa") do |session|
      script = "ruby ./get_password_policy.rb -e production -p #{partner_id} -t #{type}"
      output = session.exec!("cd /var/www/bus/script && #{script}")
      result = Hash[*output.match(/#<PasswordPolicy (.+)>/)[1].split(/(,|:) /).delete_if{|d| d.match(/,|:/)}.map {|d|d.gsub('true', 't').gsub('false', 'f')}]
    end
  end

  def ssh_phoenix(cmd)
    host = QA_ENV['phoenix01_host']
    user, password = QA_ENV['ssh_login'], QA_ENV['ssh_password']
    Net::SSH.start(host, user , :password => password, :host_key => "ssh-rsa" ) {|ssh|  return ssh.exec!(cmd)}
  end

  def ssh_bus(cmd)
    host = QA_ENV['client_host']
    user, password = QA_ENV['ssh_login'], QA_ENV['ssh_password']
    Net::SSH.start(host, user , :password => password, :host_key => "ssh-rsa") {|ssh|  ssh.exec!(cmd)}
  end

  def ssh_linux_machine(cmd)
    host = CONFIGS['linux']['host']
    user, password = CONFIGS['linux']['user'], CONFIGS['linux']['password']
    result = []
    Net::SSH.start(host, user , :password => password, :host_key => "ssh-rsa" ) {|ssh|  result = ssh.exec!(cmd)}
    result
  end
end

module SSHRecordOverdraft
  HOST = QA_ENV['client_host']
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

  # Public: Connect to bus client, run the record_overdraft script and return results
  #
  # @partner_id [String] '123456'
  #
  # Example
  #  SSHRecordOverdraft.record_overdraft('123456')
  #
  # @return [String] "Partner #{d{6}} is using autogrow and is overdrafted on its Generic license by #{.+} GB"
  def record_overdraft(partner_id)

    Net::SSH.start(HOST, USER, :password => PASSWORD) do |session|
      script = "script/record_overdrafts -e production -p #{partner_id}"
      output = session.exec!("cd /var/www/bus && #{script}")
      output = output.scan(/Partner (\d+) is using autogrow and is overdrafted on its Generic license by (\d+) GB/)
      output = "Partner #{output[0][0].to_s} is using autogrow and is overdrafted on its Generic license by #{output[0][1].to_s} GB"
    end
  end
end

module SSHReap

  def enable_cybersoure_payment_force_failure
    #This makes mozyhome payments fail
    cmd = 'cd /etc'
    cmd += '; touch cybersource_payment_force_failure'
    cmd += '; /etc/init.d/apache2 restart'
    ssh_phoenix(cmd)
  end

  def disable_cybersoure_payment_force_failure
    #This makes mozyhome payments work again
    cmd = 'cd /etc'
    cmd += '; rm cybersource_payment_force_failure'
    cmd += '; /etc/init.d/apache2 restart'
    ssh_phoenix(cmd)
  end

  def run_phoenix_process_subscription_script(user_id)
    cmd = 'cd /var/www/phoenix'
    cmd += "; script/process_subscriptions -e production -u #{user_id}"
    ssh_phoenix(cmd)
  end

  def run_phoenix_send_notification_script(user_id)
    cmd = 'cd /var/www/phoenix'
    cmd += "; script/send_initial_renewal_notification -e production -u #{user_id}"
    ssh_phoenix(cmd)
  end

  def change_reap_yml_file(user_id,days_ago)

    fail('Reaps needs a User ID') if user_id.nil?

    #Get reap.yml from server
    cmd = 'cd /var/www/bus/config/'
    cmd += '; cat reap.yml'
    reap_yml = ssh_bus(cmd)

    #Edit reap.yml
    edited_yml = ''
    reap_yml.each_line do |line|
      if line.include? 'user_ids:'
        line = line.gsub('[',']').split(']')
        line = "#{line[0]}[#{user_id}]#{line[2]}"
      elsif line.include? 'reap_restart_date:'
        line = "#{line.split(/'/)[0]} '#{Date.today - days_ago}'\n"
      end
      edited_yml += line
    end

    #Update reap.yml on server
    cmd = 'cd /var/www/bus/config/'
    cmd += "; echo \"#{edited_yml}\" > reap.yml"
    ssh_bus(cmd)
  end

  def start_reap
    cmd = 'cd /var/www/bus'
    cmd += '; script/reap -v -f -e production mozy_home_delinquent'
    ssh_bus(cmd)
  end

  def start_reap_free
    cmd = 'cd /var/www/bus'
    cmd += '; script/reap -d -v -f -e production free_inactive'
    ssh_bus(cmd)
  end

end


module SSHPushConnector
  HOST = "10.135.10.85"
  USER = "Administrator"
  PASSWORD = "QAP@SSw0rd"

  def push_users(partner_id)

    Net::SSH.start(HOST, USER, :password => PASSWORD) do |session|
      script = "./MozyLDAPConnector.exe -partner_id #{partner_id} -ignore_certificates true -test_mode false -bifrost_url '#{QA_ENV['bifrost_host']}'"
      output = session.exec!("cd /cygdrive/c/PROGRA~2/MozyLDAPConnector/ && #{script}")
    end
  end
end

module SSHKalypsoE2E
  HOST = "10.135.10.214"
  USER = "MozyQA"
  PASSWORD = "Password1!"

  def run_adfs_activation_and_backup(client, env, subdomain, user)

    Net::SSH.start(HOST, USER, :password => PASSWORD) do |session|
      script = "ruby adfsactivationandbackup.rb -c #{client} -e #{env} -s #{subdomain} -u #{user} -p '' -l"
      output = session.exec!("cd /cygdrive/c/kalypso-automation/endtoend/ && #{script}")
    end
  end
end

module SSHLinuxE2E
  HOST = CONFIGS['linux']['host']
  USER = CONFIGS['linux']['user']
  PASSWORD = CONFIGS['linux']['password']
  PATH = CONFIGS['linux']['path']

  # Public: upload the file to remote server
  #
  def upload(local_path, remote_path)
    Net::SCP.start(HOST, USER, :password => PASSWORD, :host_key => "ssh-rsa") do |scp|
      scp.upload(local_path, remote_path)
    end
  end

  # Public: check if the linux machine is reachable and linux client is installed
  #
  def check_client_status
    cmd = 'sudo service mozybackup start'
    cmd += '; sudo service mozybackup status'
    begin
      ssh_linux_machine(cmd)
    rescue Exception => ex
      puts ex.to_s
    end
  end

  # clean up linux client env, set up new client env according to qa env and partner codename
  #
  def setup_env(env, codename)
    cmd = 'sudo mozyutil stop'
    cmd += '; sudo mozyutil unlink'
    cmd += "; cd #{PATH}"
    cmd += '; rm -r LinuxTestFiles'
    cmd += '; sudo mozyutil clearbackupdirs'
    cmd += "; sudo sh changenetwork.sh -n #{env} -c #{codename} -x"
    cmd += '; sudo service mozybackup restart'
    ssh_linux_machine(cmd)
  end


  def activate_machine(username, password)
    cmd = "cd #{PATH}"
    cmd += "; sudo mozyutil activate --email #{username} --pass #{password}"
    ssh_linux_machine(cmd)
  end

  # Public: add files in backup dir
  # default type is true, means use fixed file upload_file.txt
  # if type is false, then use dd command to generate random files according to file_size and file_num
  #
  def add_files(file_size = nil, file_num = nil, type = true)
    cmd = "cd #{PATH}"
    cmd += '; mkdir LinuxTestFiles'
    cmd += "; sudo mozyutil addbackupdirs --path #{PATH}/LinuxTestFiles"
    if type
      cmd += '; cp upload_file.txt ./LinuxTestFiles'
    else
      cmd += "; dd if=/dev/urandom of=./LinuxTestFiles/output.dat  bs=#{file_size}  count=#{file_num}"
    end
    ssh_linux_machine(cmd)
  end

  def start_backup
    cmd = 'sudo mozyutil start'
    ssh_linux_machine(cmd)
  end

  def stop_backup
    cmd = 'sudo mozyutil stop'
    ssh_linux_machine(cmd)
  end

  def get_backup_status
    cmd = 'sudo mozyutil state'
    ssh_linux_machine(cmd)
  end

  def get_codename(company_type)
    return @codename unless @codename.nil?
    @codename = case company_type
                  when 'MozyEnterprise'
                    "MozyEnterprise"
                  when 'MozyEnterprise DPS'
                    "MozyEnterprise"
                  when 'MozyPro'
                    "mozypro"
                  when 'MozyHome'
                    'mozy'
                  when "Reseller"
                    'mozypro'
                  else
                    company_type
                end
  end

  # Have bds-boots service restart after deleting a AD user, otherwise, fail to privision a user on Bus Console
  def restart_bds_boots_service
    cmd = "/etc/init.d/bds-boots stop"
    cmd += "; /etc/init.d/bds-boots start"
    host = QA_ENV['authproxy01_host']
    user, password = QA_ENV['authproxy01_user'], QA_ENV['authproxy01_pass']
    sshHelperLog("host: " + host)
    sshHelperLog("user: " + user)
    sshHelperLog("password: " + password)
    sshHelperLog("cmd" + cmd)
    result = []
    Net::SSH.start(host, user , :password => password, :host_key => "ssh-rsa" ) {|ssh|  result = ssh.exec!(cmd)}
    sshHelperLog("result: " + result.to_s)
    result
  end

  #======puts customized comment into the single test case execution log======
  def sshHelperLog(text)
    $logFile.puts("======[ssh_helper Log] " + text.to_s + "======\n")
  end

end
