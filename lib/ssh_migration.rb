require 'net/ssh'
module SSHMigration

  BUS_HOST = QA_ENV['client_host']
  NJORD_HOST = QA_ENV['njord_host']
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

# PUBLIC: Manual migration of partner to pooled storage
# 	in the future there will be a button in the partner
#	detail UI that will do the same thing as this script
  def migrate_to_pooled_storage(partner_id)

    Net::SSH.start(BUS_HOST, USER, :password => PASSWORD, :host_key => "ssh-rsa") do |session|
      Log.debug "LogQA: ssh-rsa is the default ssh host key======"
      succ_msg = "1 partners have been migrated successfully, 0 failed"
      script = "script/migrate_to_pooled_storage.rb -e production -p #{partner_id}"
      output = session.exec!("cd /var/www/bus && #{script}")

      log_dir = output.match(/log redirected to (\/root\/\d{4}\.\d{2}\.\d{2}\.\d{2}\.\d{2}\.\d{2}\.log\/\d+\.log)/)
      raise "Error: Cannot migrate partner: #{partner_id} to pooled storage.\n #{output}" if log_dir.nil?

      log_file = session.exec!("cat #{log_dir}")
      raise "Error: Cannot migrate partner: #{partner_id} to pooled storage.\n #{log_file}" if log_file.match(succ_msg).nil?
    end
  end

  def migrate_to_aria(partner_id_begin, partner_id_end = nil)
    num = partner_id_end.nil? ? 1 : (partner_id_end.to_i - partner_id_begin.to_i)
    partner_id_end = partner_id_begin if partner_id_end.nil?
    Net::SSH.start(NJORD_HOST, USER, :password => PASSWORD) do |session|
      succ_msg = "#{num} partners have been successfully migrated"
      script = "script/move_partners_to_aria -s #{partner_id_begin} -n #{partner_id_end} -m -e production"
      Log.debug "script is #{script}"
      output = session.exec!("cd /var/www/njord && #{script}")
      raise "Error: Cannot migrate partner from #{partner_id_begin} to #{partner_id_end} to aria.\n " if output.match(succ_msg).nil?
    end
  end
end
