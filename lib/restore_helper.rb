require 'pg'
module RestoreHelper
  @db_host = QA_ENV['db_host']
  @db_port = QA_ENV['db_port']
  @db_user = QA_ENV['db_user']
  @db_name = QA_ENV['db_restores']

  def self.get_restore_id(restore_name)
    sleep 10
    begin
      conn = PG::Connection.open(:host => @db_host, :port=> @db_port, :user => @db_user, :dbname => @db_name)
      sql = "select id from restores where name = '#{restore_name}' order by id DESC limit 1;"
      c = conn.exec sql
      return c.values[0][0].to_s
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def self.set_restore_burned_mailed_time(type, id, time = 'now()')
    begin
      conn = PG::Connection.open(:host => @db_host, :port=> @db_port, :user => @db_user, :dbname => @db_name)
      sql = "update dvd_orders set #{type}_at = #{time} where restore_id = #{id};"
      conn.exec sql
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

end