require 'pg'
module DBHelper
  @host = QA_ENV['db_host']
  @port = QA_ENV['db_port']
  @db_user = QA_ENV['db_user']
  @db_name = QA_ENV['db_name']

  # Public: verify home user by user_name
  #
  def change_email_verified_at(username)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      t = (Time.now)
      Log.debug "########Time.now is #{Time.now}"
      Log.debug "########t is #{t}"
      Log.debug "########username is #{username}"
      sql = "update users set email_verified_at='#{t}' where username='#{username}';"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # Public: change user's last sync at time to days's before by user_id
  #
  def change_last_sync_at(user_id, days)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      t = (Time.now - (days + 10) * 24 * 3600)
      Log.debug "########Time.now is #{Time.now}"
      Log.debug "########t is #{t}"
      Log.debug "########user_id is #{user_id}"
      sql = "update user_sync_details set last_sync_at='#{t}' where user_id='#{user_id}';"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # update machine deleted time to days's before by machine id
  def update_machine_deleted_at(machine_id, days)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      t = (Time.now - days * 24 * 3600)
      Log.debug "########Time.now is #{Time.now}"
      Log.debug "########days is #{days}"
      sql = "update machines set deleted_at='#{t}' where ID='#{machine_id}';"
      Log.debug sql
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end

  end

  def get_machine_id_by_license_key(license_key)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select machine_id from mozy_pro_keys where keystring ='#{license_key}';"
      c = conn.exec(sql)
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_machine_info(machine_id, quota, time = 'now()')
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE machines SET space_used = #{quota}::bigint*1024*1024*1024 , pending_space_used = 0, patches = 0, files = 1, last_backup_at = #{time}, last_successful_backup_at = #{time} WHERE id = #{machine_id};;"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def machine_available_quota(machine_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select machine_available_quota(#{machine_id});"
      c = conn.exec(sql)
      c.values[0][0].to_i/(1024 ** 3)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where username like '%@emc.com%' and deleted = false and creation_time IS NOT NULL and username not in (select username from public.admins where username like '%@emc.com%' and deleted_at IS NULL) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_username(parent, username_prefix = nil)
    partner_id = case parent
                              when 'ME'
                                "mozy_enterprise_partner_id"
                              when 'MC'
                                "mozy_corp_partner_id"
                              when 'MP'
                                "mozy_pro_partner_id"
                              when 'MH'
                                "mozy_consumer_partner_id"
                              when 'MEO'
                                "mozy_enterprise_old_partner_id"
                              else
                               puts "Parent partner code entered (#{parent}) is not supported"
                            end
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from users u where u.user_group_id in (
              select ug.id as ug_id from user_groups ug where ug.pro_partner_id in (
                select id from pro_partners sub_pt, (
                  select tree_sortkey from pro_partners p where p.id in (
                    select cast(value as integer) from global_settings where key = '#{partner_id}')) as key
              where sub_pt.tree_sortkey between key.tree_sortkey and tree_right(key.tree_sortkey)))
            and u.enforce_unique_username = true and u.userhash is not null and u.username is not null and u.creation_time is not null"
      sql += " and username like '#{username_prefix}%'" unless username_prefix.nil?
      sql += ' and deleted = false limit 2;'
      c = conn.exec(sql)
      Log.debug("Email from tree #{parent} = #{c.values[-1][0]}")
      c.values[-1][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end

  end

  def get_admin_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      #sql = "select username from public.admins where username like '%@gmail.com%' and deleted_at IS NULL and passwordhash IS NOT NULL and username not in (select username from users where username like '%@gmail.com%' and deleted = false) order by id DESC limit 1;"
      sql = "select username from public.admins where username like 'mozyautotest%@emc.com%' and deleted_at IS NULL and passwordhash IS NOT NULL and username not in (select username from users where username like 'mozyautotest%@emc.com%' and deleted = false) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_mh_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from users where username like '%@emc.com%' and deleted = false and user_group_id = 4151 order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_mh_cybersource_id(user_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select cybersource_id from user_payment_infos where user_id = #{user_id};"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_suspended_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where (username like '%@decho.com%' or username like '%redacted-%') and deleted = false and suspended_at NOTNULL and username not in (select username from users where username like '%@decho.com%' and deleted = false) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_deleted_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from users u1 where username SIMILAR TO '%@(gmail|emc).com%' and deleted = true and not exists (select 1 from users u2 where u2.deleted = false and u1.username = u2.username) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def create_machines(user_id, license_name, count, quota)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      current = Time.now
      license_type_id = 0
      pro_partner_id = 0
      pro_partner_name = ""
      pro_partner_id_sql = "select pro_partners.parent_pro_partner_id from pro_partners where
                  pro_partners.id = (select user_groups.pro_partner_id from user_groups where
                    user_groups.id = (select users.user_group_id from users where
                      users.id = #{user_id} limit 1)
                  limit 1)
                limit 1;"
      c = conn.exec pro_partner_id_sql
      Log.debug pro_partner_id_sql
      pro_partner_id = c.values[0][0].to_i
      while Time.now < current + CONFIGS['global']['default_wait_time']
        sql = "select license_types.id from license_types where
                license_types.name = '#{license_name}' and
                license_types.pro_partner_id = #{pro_partner_id} limit 1;"
        c = conn.exec sql
        Log.debug sql
        if !c.values.empty?
          license_type_id = c.values[0][0].to_i
          break
        else
          pro_partner_id_sql = "select pro_partners.parent_pro_partner_id, pro_partners.name from pro_partners where
                  pro_partners.id = '#{pro_partner_id}' limit 1;"
          c = conn.exec pro_partner_id_sql
          Log.debug pro_partner_id_sql
          pro_partner_id = c.values[0][0].to_i
          pro_partner_name = c.values[0][1].to_s
        end
      end



      # sql = "select license_types.id from license_types where
      #           license_types.name = '#{license_name}' and
      #           license_types.pro_partner_id = (select pro_partners.parent_pro_partner_id from pro_partners where
      #             pro_partners.id = (select user_groups.pro_partner_id from user_groups where
      #               user_groups.id = (select users.user_group_id from users where
      #                 users.id = #{user_id} limit 1)
      #             limit 1)
      #           limit 1)
      #         limit 1;"
      # c = conn.exec sql
      # Log.debug sql
      # license_type_id = c.values[0][0].to_i

      sql = "select id from mozy_pro_keys where
              activated_at is null and
              user_group_id = (select user_group_id from users where users.id = #{user_id} limit 1) and
              license_type_id = #{license_type_id}
            limit #{count};"
      mozy_pro_key_ids = conn.exec(sql).values.map(&:first)
      Log.debug sql
      mozy_pro_key_ids.each_with_index do |mozy_pro_key_id, index|
        Log.debug "#{index} / #{mozy_pro_key_ids.size}"
        sql = "insert into machines(alias, machine, user_id, site, sync, created_at, updated_at) values ('AUTOTEST', 'machinehash#{Time.now.to_i+index}', #{user_id}, '#{QA_ENV['data_center']}', false, now(), now());"
        conn.exec sql
        Log.debug sql

        sql = "select id from machines where user_id = #{user_id} order by id desc limit 1"
        c = conn.exec sql
        Log.debug sql
        machine_id = c.values[0][0].to_i

        quota_string = ""
        quota_string = "quota = 0, quota_purchased = 0," if pro_partner_name == "MozyOEM"
        sql = "update machines set space_used = #{quota}::bigint*1024*1024*1024, "+ quota_string +"pending_space_used = 1024, patches = 0, files = 1, last_client_version = null,last_backup_at = now() where id = #{machine_id};"
        conn.exec sql
        Log.debug sql

        sql = "insert into machine_storage_pools(owner_id, license_type_id, created_at, updated_at) values(#{machine_id}, #{license_type_id}, now(), now());"
        conn.exec sql
        Log.debug sql

        sql = "update mozy_pro_keys set machine_id = #{machine_id}, activated_at = now() where id = #{mozy_pro_key_id}";
        conn.exec sql
        Log.debug sql
      end
    rescue PG::Error => e
      puts "postgres error: #{e}"
      puts "#{$!}\n#{$@.join("\n")}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_id_by_email(email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select id from users where username = '#{email}' limit 1;"
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_admin_id_by_email(email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select id from admins where username = '#{email}' limit 1;"
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def delete_upi_by_id(id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "delete from user_payment_infos where user_id = '#{id}';"
      c = conn.exec sql
      c.values.to_s
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_db_password_config(partner_id, type='user')
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from password_policies where pro_partner_id = #{partner_id} and (user_type = '#{type}' or user_type = 'all');"
      puts sql
      c = conn.exec sql
      if c.num_tuples.zero?
        #0 db record searched out
        nil
      else
        c[0]
      end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_password_character_classes(password_policy_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select character_class from password_policies_character_classes where password_policy_id = #{password_policy_id};"
      c = conn.exec sql
      c.field_values('character_class')
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # The date is set according to server time, MST
  def set_expiration_time(user_id,days_ago)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE subscriptions SET expiration_time='#{DateTime.now.new_offset('-07:00').to_date - days_ago.to_i} 12:12:12' WHERE user_id = #{user_id} and pending is false;" #and cancelled_at is null;
      puts sql
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def set_last_backup_attempt(user_id,weeks_ago)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE machines SET last_backup_attempt = '#{Date.today - (weeks_ago * 7)}' WHERE user_id = #{user_id};"
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def set_last_backup_at(user_id,days_ago)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE machines SET last_backup_at = '#{Date.today - days_ago}' WHERE user_id = #{user_id};"
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  # QA is investigating the time zone issue which causes the case failed - BUS-9621.
  def set_backup_suspended_at(user_id,weeks_ago)

    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      #same_date = (Time.new.hour - 15 >= 0)
      if time_zone_in_same_day
        dbLog("backup_suspended_at - local date and ruby script execution date are the same day")
        sql = "UPDATE users SET backup_suspended_at = '#{Date.today - (weeks_ago * 7)}' WHERE id = #{user_id};"
      else
        dbLog("backup_suspended_at - local date and ruby script execution date are NOT the same day")
        sql = "UPDATE users SET backup_suspended_at = '#{Date.today - 1 - (weeks_ago * 7)}' WHERE id = #{user_id};"
      end
      dbLog(sql)
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def set_gc_notify_at(user_id,weeks_ago)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      #same_date = (Time.new.hour - 15 >= 0)
      if time_zone_in_same_day
        dbLog("gc_notify_at - local date and ruby script execution date are the same day")
        sql = "UPDATE users SET gc_notify_at = '#{Date.today - (weeks_ago * 7)}' WHERE id = #{user_id};"
      else
        dbLog("gc_notify_at - local date and ruby script execution date are NOT the same day")
        sql = "UPDATE users SET gc_notify_at = '#{Date.today - 1 - (weeks_ago * 7)}' WHERE id = #{user_id};"
      end
      dbLog(sql)
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  ## Helpers ##
  def get_gc_notify_at(user_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select gc_notify_at from users where id = #{user_id};"
      conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_table(user_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from users where id = #{user_id};"
      conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_partner_setting_value(partner_id,setting_name)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select value from pro_partner_settings where key='#{setting_name}' and pro_partner_id = #{partner_id};"
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_global_setting_value(setting_name)
    begin
      sql = "select value from global_settings where key='#{setting_name}';"
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_partner_delete_timestamp(partner_id, days)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "update pro_partner_details set value=value::timestamp - interval '#{days} days' where key='purge_requested_on' and pro_partner_id=#{partner_id};"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_action_audits(action,admin_id,type)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT * from action_audits where action = '#{action}' and effective_admin_id = #{admin_id} order by id desc limit 1;"
      sql = "SELECT * from action_audits where action = '#{action}' and actual_admin_id = #{admin_id} order by id desc limit 1;" if type == 'actual'
      Log.debug sql
      c = conn.exec(sql)
      [c.values[0][0],c.values[0][1],c.values[0][2], c.values[0][3],c.values[0][4], c.values[0][5]]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  #   id   | action_audit_id | column_name  | table_name | record_id |               changed_from               |                changed_to                | action |      performed_at
  # 736289 |        12839186 | passwordhash | admins     |    563261 | 9bc34549d565d9505b287de0cd20ac77be1d3f2c | 86ba9a22970c2feb2d3095f889acf4c4e42473d5 | update | 2015-08-14 20:45:55-06
  def get_model_audits(action_audit_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT * from model_audits where action_audit_id = #{action_audit_id} order by id desc limit 1;"
      Log.debug sql
      c = conn.exec(sql)
      if c.values[0].nil?
        []
      else
        [c.values[0][0],c.values[0][1],c.values[0][2], c.values[0][3],c.values[0][4], c.values[0][5], c.values[0][6], c.values[0][7]]
      end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_info_from_admins(username)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT * from admins where username='#{username}' order by id desc limit 1;"
      Log.debug sql
      c = conn.exec(sql)
      [c.field_values('id')[0],c.field_values('passwordhash')[0]]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_users_passwords_expires_at_yesterday(user_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "update users_passwords set expires_at = TIMESTAMP 'yesterday' where user_id='#{user_id}';"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_count_seed_device_id(seed_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT count(*) from pro_resource_orders where seed_device_order_id = #{seed_id};"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
     rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_model_audits_record(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select count(id) from model_audits where action_audit_id in (select id from action_audits where effective_admin_id in (select root_admin_id from pro_partners where id = #{partner_id}) order by id desc limit 1);"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_machine_available_quota(machine_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT machine_available_quota(#{machine_id});"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_machines_last_update_time(machine_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE machines SET last_successful_backup_at = (current_timestamp - interval '0.5 hours' ) WHERE id = #{machine_id};"
      Log.debug sql
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_customcd_order_id(seed_device_order_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select customcd_order_id from seed_device_orders_customcd_orders where seed_device_order_id=#{seed_device_order_id};"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_customcd_order_id(seed_id,customcd_order_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE seed_device_orders_customcd_orders SET customcd_order_id = #{customcd_order_id} WHERE seed_device_order_id = #{seed_id};"
      Log.debug sql
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_mail_domain_form_dea_services
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT mail_domain FROM dea_services ORDER BY id limit 1;"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  def get_partner_adr_policy_name(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select adr_policy_name from pro_partners where id = #{partner_id};"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_groups_adr_from_partner(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select adr_policy_name from user_groups where pro_partner_id = #{partner_id};"
      Log.debug sql
      c = conn.exec(sql)
      c.field_values('adr_policy_name')
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_group_adr_policy_name(partner_id, user_group_name)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select adr_policy_name from user_groups where pro_partner_id = #{partner_id} and name = '#{user_group_name}';"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_main_adr_jobs(object_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from adr_jobs where object_id = #{object_id} and main_job_id is null;"
      Log.debug sql
      c = conn.exec(sql)
      c.values
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_sub_adr_jobs(main_job_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from adr_jobs where main_job_id = #{main_job_id};"
      Log.debug sql
      c = conn.exec(sql)
      c.values
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_group_id(partner_id, user_group_name)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select id from user_groups where pro_partner_id = #{partner_id} and name = '#{user_group_name}';"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  #====================================
  # public      : get id (main job id) from adr_jobs table by given partner id
  #
  # @partner_id : partner id
  #
  # @return     : return the id of the adr job record. return nil if no result found.
  #
  # example     : DBHelper.get_main_job_id("426024")
  #====================================
  def get_main_job_id(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select id from adr_jobs where object_id = #{partner_id};"
      Log.debug sql
      c = conn.exec(sql)
      #if no result found, c.ntuples == 0
      if c.ntuples > 0 then c.values[0][0] else nil end
      #c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  #====================================
  # public         : get device record with specified columns from machine table
  #
  # @query_columns : column table on machine table
  # @device_id     : device id
  #
  # @return : return specified column values of the given device id
  #
  # example : DBHelper.get_machine_record(["id", "machine", "vc_policy_name", "vc_policy_grace_period", "vc_status"], "426024")
  #====================================
  def get_machine_record(query_columns, device_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      str = ""
      query_columns.each do |col|
        str = str + ', ' + col
      end
      #======replace the first comma(,) with empty
      str.sub!(/,/, '')
      sql = "select" + str + " from machines where id = #{device_id};"
      Log.debug sql
      c = conn.exec(sql)
      #if no result found, c.ntuples == 0
      if c.ntuples > 0 then c.values else nil end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  #====================================
  # public     : get device adr policy name from machine table in db
  #
  # @device_id : device id
  #
  # @return    : return device adr policy name or nil
  #
  # example    : DBHelper.get_device_adr_policy_name_by_device_id("7707388")
  #====================================
  def get_device_adr_policy_name_by_device_id(device_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select vc_policy_name from machines where id = #{device_id};"
      Log.debug sql
      c = conn.exec(sql)
      if c.ntuples > 0 then c.values[0][0] else nil end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  #====================================
  # public     : get device adr policy name from machine table in db
  #
  # @device_id : device id
  #
  # @return    : return device adr policy name or nil
  #
  # example    : DBHelper.get_device_adr_policy_name_by_device_id("7707388")
  #====================================
  def get_device_adr_policy_name_by_user_id_and_device_name(del_ex, user_id, device_name)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      if del_ex == "deleted"
        sql = "select vc_policy_name from machines where user_id = #{user_id} and alias = '#{device_name}' and deleted = 't';"
      else
        sql = "select vc_policy_name from machines where user_id = #{user_id} and alias = '#{device_name}' and deleted = 'f';"
      end
      Log.debug sql
      c = conn.exec(sql)
      if c.ntuples > 0 then c.values[0][0] else nil end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_partner_id_by_admin_email(admin_email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select pp.id from pro_partners pp left join admins a on pp.root_admin_id = a.id where a.username = '#{admin_email}' order by pp.id desc limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_count_delayed_job(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select count(*) from jobs j left join job_results jr on j.id=jr.job_id left join delayed_jobs dj on jr.delayed_job_id=dj.id where j.pro_partner_id=#{partner_id} and dj.run_at > now();"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_partner_admin_ip(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select requesting_ip from pro_partners where id = #{partner_id};"
      Log.debug sql
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # delete reports that created by automation by email prefix
  def delete_reports_by_email_prefix(admin_email_prefix = CONFIGS['global']['email_prefix'])
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      # delete scheduled delayed_jobs
      sql = "delete from delayed_jobs where id in (select jr.delayed_job_id from jobs j left join job_results jr on jr.job_id = j.id where j.subscribers like '#{admin_email_prefix}' and j.deleted_at is null);"
      c = conn.exec(sql)
      puts "#{c.cmd_tuples} delayed_jobs records of #{admin_email_prefix} is deleted successfully"
      # delete job_results
      sql = "update job_results set deleted_at = now() where id in (select jr.id from jobs j left join job_results jr on jr.job_id = j.id where j.subscribers like '#{admin_email_prefix}' and j.deleted_at is null);"
      c = conn.exec(sql)
      puts "#{c.cmd_tuples} job_results records of #{admin_email_prefix} is updated successfully"
      # delete jobs
      sql = "update jobs set deleted_at = now() where subscribers like '#{admin_email_prefix}' and deleted_at is null;"
      c = conn.exec(sql)
      puts "#{c.cmd_tuples} jobs records of #{admin_email_prefix} is updated successfully"
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # delete reports that created by automation by partner id
  def delete_reports_by_partner_id(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      # delete scheduled delayed_jobs
      sql = "delete from delayed_jobs where id in (select jr.delayed_job_id from jobs j left join job_results jr on jr.job_id = j.id where j.pro_partner_id=#{partner_id} and j.deleted_at is null);"
      c = conn.exec(sql)
      puts "#{c.cmd_tuples} delayed_jobs records of partner #{partner_id} is deleted successfully"
      # delete job_results
      sql = "update job_results set deleted_at = now() where id in (select jr.id from jobs j left join job_results jr on jr.job_id = j.id where j.pro_partner_id=#{partner_id} and j.deleted_at is null);"
      c = conn.exec(sql)
      puts "#{c.cmd_tuples} job_results records of partner #{partner_id} is updated successfully"
      # delete jobs
      sql = "update jobs set deleted_at = now() where pro_partner_id=#{partner_id} and deleted_at is null;"
      c = conn.exec(sql)
      puts "#{c.cmd_tuples} jobs records of partner #{partner_id} is updated successfully"
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def delete_user_by_email(email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE users SET deleted = 't', deleted_time = now(), userhash = null WHERE username = '#{email}' and deleted_time is null;"
      c = conn.exec sql
      c.check
      puts sql
      if c.cmd_tuples >= 1
        puts "#{c.cmd_tuples} records of #{email} is updated successfully"
      else
        puts "Nothing updated for #{email}"
      end
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def delete_users_by_email(email)
    dbLog("Begin to delete user by email")
    begin
      dbLog("host: " + @host.to_s)
      dbLog("port: " + @port.to_s)
      dbLog("db user: " + @db_user.to_s)
      dbLog("db name: " + @db_name.to_s)
      dbLog("begin to connect to the PG")
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      dbLog("connection succeed")
      sql = "UPDATE users SET deleted = 't', deleted_time = now(), userhash = null WHERE username like '#{email}' and deleted_time is null;"
      dbLog("sql clause is: " + sql)
      c = conn.exec sql
      c.check
      puts sql
      if c.cmd_tuples >= 1
        puts "#{c.cmd_tuples} records of #{email} is updated successfully"
      else
        puts "Nothing updated for #{email}"
      end
    rescue PGError => e
      puts 'postgres error'
      puts e
      dbLog(e.to_s)
    ensure
      conn.close unless conn.nil?
    end
  end

  def purge_user_by_email(email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT id FROM users WHERE username = '#{email}';"
      puts sql
      c = conn.exec sql
      if c.ntuples >= 1
        puts "#{c.ntuples} users named #{email} to be purged"
      else
        puts "No user named #{email} to be purged"
        return
      end

      # to do: delete all machines include sync of this user, and return quota to user group
      # as there is no machines for automation created fedid users, the delete machine sql is not needed now

      # delete user_storage_pools
      sql = "DELETE FROM user_storage_pools WHERE owner_id in (#{c.column_values(0).join(',')});"
      puts sql
      usp = conn.exec sql
      puts "#{usp.cmd_tuples} records deleted in table user_storage_pools"

      # delete user_sync_details
      sql = "DELETE FROM user_sync_details WHERE user_id in (#{c.column_values(0).join(',')});"
      puts sql
      usd = conn.exec sql
      puts "#{usd.cmd_tuples} records deleted in table user_sync_details"

      # delete users
      sql = "DELETE FROM users WHERE id in (#{c.column_values(0).join(',')});"
      puts sql
      u = conn.exec sql
      puts "#{u.cmd_tuples} records deleted in table users"

    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def purge_users_by_email(email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT id FROM users WHERE username like '#{email}';"
      puts sql
      c = conn.exec sql
      if c.ntuples >= 1
        puts "#{c.ntuples} users named #{email} to be purged"
      else
        puts "No user named #{email} to be purged"
        return
      end

      # to do: delete all machines include sync of this user, and return quota to user group
      # as there is no machines for automation created fedid users, the delete machine sql is not needed now

      # delete user_storage_pools
      sql = "DELETE FROM user_storage_pools WHERE owner_id in (#{c.column_values(0).join(',')});"
      puts sql
      usp = conn.exec sql
      puts "#{usp.cmd_tuples} records deleted in table user_storage_pools"

      # delete user_sync_details
      sql = "DELETE FROM user_sync_details WHERE user_id in (#{c.column_values(0).join(',')});"
      puts sql
      usd = conn.exec sql
      puts "#{usd.cmd_tuples} records deleted in table user_sync_details"

      # delete users
      sql = "DELETE FROM users WHERE id in (#{c.column_values(0).join(',')});"
      puts sql
      u = conn.exec sql
      puts "#{u.cmd_tuples} records deleted in table users"
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  #======puts customized comment into the single test case execution log======
  def dbLog(text)
    $logFile.puts("======[DB Log] " + text.to_s + "======\n")
  end

  # delete dialects by partner id
  def delete_dialects_by_partner_id(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "delete from dialects where pro_partner_id=#{partner_id};"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # Public: delete promot from plsql
  def delete_promo(promo)
    dbLog("delete promption from promotions table")
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE promotions SET deleted_at = now() WHERE code = '#{promo}' and deleted_at is null;"
      dbLog("delete promotion from promotions table by the plsql clause: " + sql)
      c = conn.exec(sql)
      dbLog("result: " + c.to_s)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end

    dbLog("delete promption from pro_promotions table")
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE pro_promotions SET deleted_at = now() WHERE code = '#{promo}' and deleted_at is null;"
      dbLog("delete promotion from pro_promitions table by the plsql clause: " + sql)
      c = conn.exec(sql)
      dbLog("result: " + c.to_s)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end




  end

  # return one record of pro_partners table as a hash
  def get_pro_partner_table(partner_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from pro_partners where id = #{partner_id};"
      c = conn.exec sql
      c.[](0)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  #======this method is to help for some sql clauses having date updated directly in db which ignores time zone======
  #======different time zone will cause some casue failed due to not in the same day======
  #======this method will convert date to the date align with the db time zone======
  def time_zone_in_same_day
    local_time_utc_offset = Time.new.strftime("%:z").to_i
    dbLog("local machine date time zone utc offset is #{local_time_utc_offset.to_s}")
    time_difference = local_time_utc_offset + 7
    same_date = (Time.new.hour - time_difference >= 0)
    #timezone_array=[same_date, time_difference]
    return same_date
  end


  def update_account_attribute_key(key, component)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE account_attribute_keys SET component = '#{component}' where key = '#{key}';"
      dbLog("update the component of account attribute key by the plsql clause: " + sql)
      c = conn.exec sql
      dbLog("result: " + c.to_s)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


  def delete_account_attribute_key(key)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "DELETE from account_attribute_keys where key = '#{key}';"
      dbLog("delete the account attribute key by the plsql clause: " + sql)
      c = conn.exec sql
      dbLog("result: " + c.to_s)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_seed_device_order_types(storage_size, sku_size, sku_name)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "update seed_device_order_types set sku_size = '#{sku_size}', sku_name = '#{sku_name}' where storage_size = '#{storage_size}';"
      dbLog("update seed_device_order_types by the plsql clause: " + sql)
      c = conn.exec sql
      dbLog("result: " + c.to_s)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end

  end

end
