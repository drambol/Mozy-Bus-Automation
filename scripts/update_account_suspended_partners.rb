require 'pg'
require File.expand_path('../../test_sites/configs/configs_helper', __FILE__)
@host = QA_ENV['db_host']
@port = QA_ENV['db_port']
@db_user = QA_ENV['db_user']
@db_name = QA_ENV['db_name']

def delete_backup_suspended_at_value(value,type)
  begin
    if type == "email"
      sql = "update pro_partners set backup_suspended_at=null where
              pro_partners.id = (select pro_partners.id from pro_partners, admins where
              pro_partners.root_admin_id = admins.id AND admins.username ='#{value}');"
    else
      sql = "update pro_partners set backup_suspended_at = null where name = '#{value}';"
    end
    conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
    c = conn.exec sql
    c.check
    puts sql
    if c.cmd_tuples >= 1
      puts "'backup_suspended_at' of '#{value}' is updated successfully"
    else
      puts "Nothing updated for '#{value}'"
    end
  rescue PGError => e
    puts 'postgres error'
  ensure
    conn.close unless conn.nil?
  end
end

delete_backup_suspended_at_value("congshanl+fedid+proxy@mozy.com","email")

delete_backup_suspended_at_value("congshanl+fedid+proxy+1@mozy.com","email")

delete_backup_suspended_at_value("kalen.quam+qa6+marilyn+dean+1118@mozy.com","email")

delete_backup_suspended_at_value("test_resource_summary_enterprise@auto.com","email")

delete_backup_suspended_at_value("test_resource_summary_enterprise_subpartner@auto.com","email")

delete_backup_suspended_at_value("test_resource_summary_bundled@auto.com","email")

delete_backup_suspended_at_value("resource_summary_bundled_subpartner@auto.com","email")

delete_backup_suspended_at_value("qa1+sub+admin+19370@mozy.com","email")

delete_backup_suspended_at_value("qa1+tc+19370+reserved@mozy.com","email")

delete_backup_suspended_at_value("qa1+tc+19867+reserved@mozy.com","email")

delete_backup_suspended_at_value("qa1+tc+19811+admin1@mozy.com","email")

delete_backup_suspended_at_value("redacted-374495@notarealdomain.mozy.com","email")

delete_backup_suspended_at_value("qa1+tc+19953+reserved@mozy.com","email")

delete_backup_suspended_at_value("qa1+tc+19954+reserved@mozy.com","email")

delete_backup_suspended_at_value("test_bsa3040@auto.com","email")

delete_backup_suspended_at_value("redacted-36090@notarealdomain.mozy.com","email")

delete_backup_suspended_at_value("test3010_3030_3040@auto.com","email")

delete_backup_suspended_at_value("qa1+users+features+test+account@mozy.com","email")

delete_backup_suspended_at_value("last_update@auto.com","email")


delete_backup_suspended_at_value("Barclays Root - Reserved","name")

delete_backup_suspended_at_value("Charter Business Trial - Reserved","name")

delete_backup_suspended_at_value("Quigley-Effertz - Reserved","name")

delete_backup_suspended_at_value("qa1+james+lawson+1611@mozy.com","email")


