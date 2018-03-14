module MoveEnterpriseToDPS
  HOST = QA_ENV['client_host']
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

  # Public: Connect to bus client, run the move_enterprise_to_dps script and return results
  #
  # @partner_id [String] '123456'
  #
  # Example
  #  MoveEnterpriseToDPS.move_me_dps(3488823,10954221,34,true)
  def move_me_dps(partner_id, plan_no, units_no, dry_run)
    Net::SSH.start(HOST, USER, :password => PASSWORD) do |session|
      if dry_run
        script = "script/move_enterprise_to_dps -e production -p #{partner_id} -i #{plan_no} -n #{units_no} -d"
      else
        script = "script/move_enterprise_to_dps -e production -p #{partner_id} -i #{plan_no} -n #{units_no}"
      end
      Log.debug script
      session.exec!("cd /var/www/bus && #{script}")
    end
  end
end