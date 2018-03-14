# == Usage
#
#   cleanup_testdata [Options]
#
#   Purpose
#    Clean up test data before regression run or before rerun specific feature
#
# == Examples
#
#     cleanup_testdata -u             # this will delete fixed user by username created in automation
#     cleanup_testdata -r             # this will delete all reports created in automation with admin name prefix 'mozyautotest', etc
#     cleanup_testdata -e             # this will empty automation email folder
#     cleanup_testdata -a             # this will delete all fixed users, reports and empty email box

require 'getoptlong'

opts = GetoptLong.new(
    [ "--email",                   "-e",    GetoptLong::NO_ARGUMENT],
    [ "--report",                  "-r",    GetoptLong::OPTIONAL_ARGUMENT],
    [ "--report-by-partner-id",    "-I",    GetoptLong::OPTIONAL_ARGUMENT],
    [ "--ldap-user",               "-l",    GetoptLong::OPTIONAL_ARGUMENT],
    [ "--user",                    "-u",    GetoptLong::OPTIONAL_ARGUMENT],
    [ "--all",                     "-a",    GetoptLong::NO_ARGUMENT],
    [ "--help",                    "-h",    GetoptLong::NO_ARGUMENT]
)

delete_email, delete_all = false
report_email_prefix, report_partner_id, ldap_user, mozy_user = nil

if ARGV[0].nil?
  puts "Missing argument (try --help)"
  puts "Usage: -h -u -r -e"
  exit
end

begin
  opts.each do |opt, arg|
    case opt
      when '--email'
        delete_email = true
      when '--report'
        report_email_prefix = arg
      when '--report-by-partner-id'
        report_partner_id = arg
      when '--ldap-user'
        ldap_user = arg
      when '--user'
        mozy_user = arg
      when '--all'
        delete_all = true
      when '--help'
        puts <<-EOF
  cleanup_testdata [options] [value]

  -h, --help:
      show help

  --email, -e:
      delete emails in outlook email box

  --report-by-email-prefix, -r:
      delete reports that created by admin with specific email prefix
      Optional argument. If not provided, script will use email prefix "mozyautotest", etc

  --report-by-partner-id, -I:
      delete reports that created by specif partner by partner id
      Optional argument. If not provided, script will use fixed partner id

  --ldap-user, -l:
     delete user by username, deleting records in users table, refs to #136553
     Optional argument. If not provided, will delete fixed user. (for example, auto@mtdev.mozypro.local)

  --mozy-user, -u:
     delete user by username, updating users table deleted_at
     Optional argument. If not provided, will delete fixed user. (for example, 120021-test%@test.com)

  --all, -a:
     cleanup all test data include users, reports, and emails


  For example,
  if you want to delete fixed users created in automation, use
  cleanup_testdata -u

  if you want to delete specific user, use
  cleanup_testdata -u <username>
  e.g.
  cleanup_testdata -u MyTestUser20161110%@test.com

  if you want to delete reports created in automation, use
  cleanup_testdata -r

  if you want to empty automation emailbox, use
  cleanup_testdata -e

  if you want to delete all fixed data created before, using
  cleanup_testdata -a

  if you want to purge specific user (delete user record for auto@mtdev.mozypro.local, refs to #136553), use
  cleanup_testdata -l <username>

        EOF
        exit 0
    end
  end
rescue => err
  puts "#{err.class()}: #{err.message}"
  puts "Usage: -h -u -r -e"
  puts "try --help"
  exit
end


require 'logger'
require File.expand_path('../../lib/email_helper/email_helper', __FILE__)
require File.expand_path('../../test_sites/configs/configs_helper', __FILE__)
require File.expand_path('../../lib/db_helper', __FILE__)


include Email
include DBHelper

@host = QA_ENV['db_host']
@port = QA_ENV['db_port']
@db_user = QA_ENV['db_user']
@db_name = QA_ENV['db_name']

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

def delete_outlook_emails
  CONFIGS['outlook']['password'] = File.expand_path("../../#{CONFIGS['outlook']['password']}", __FILE__)
  CONFIGS['rsa']['public_key'] = File.expand_path("../../#{CONFIGS['rsa']['public_key']}", __FILE__)
  CONFIGS['rsa']['private_key'] = File.expand_path("../../#{CONFIGS['rsa']['private_key']}", __FILE__)

  mailbox = Outlook.instance
  begin
    response = mailbox.empty_folder
    Log.info 'Emails has been successfully deleted' if response
  rescue Exception => ex
    Log.error ex.message
    Log.error ex.backtrace.inspect
  end
end


if delete_email || delete_all
  delete_outlook_emails
end

if delete_all || (!report_partner_id.nil? && report_partner_id.empty?)
  # currently in qa6 use admin email prefix to delete reports instead of partner id
  fixed_report_partners = []
  Log.debug "delete report by fixed partner id #{fixed_report_partners.join(',')}"
  fixed_report_partners.each {|pid| delete_reports_by_partner_id(pid)}
elsif !report_partner_id.nil? && !report_partner_id.empty?
  Log.debug "delete report by partner id #{report_partner_id}"
  delete_reports_by_email_prefix(report_partner_id.to_i)
end

if delete_all || (!report_email_prefix.nil? && report_email_prefix.empty?)
  # currently scheduled reports with recipients include 'mozyautotest+', [DO NOT CHANGE][Bundled] Reporting Test,
  # [DO NOT CHANGE][Itemized] Reporting Test, [DO NOT CHANGE][Bundled] Resource Added Test, Linux GA Test
  fixed_report_admin = ['mozyautotest+%', 'qa1+laura+williamson+1442@decho.com','qa1+sandra+stevens+1445@decho.com', 'qa1+russell+harris+1631@decho.com%','mozybus+catherine+0401@gmail.com']
  Log.debug "delete report by fixed admin email prefix #{fixed_report_admin.join(',')}"
  fixed_report_admin.each {|email| delete_reports_by_email_prefix(email)}
elsif !report_email_prefix.nil? && !report_email_prefix.empty?
  Log.debug "delete report by admin email prefix #{report_email_prefix}"
  delete_reports_by_email_prefix(report_email_prefix)
end


if delete_all || (!mozy_user.nil? && mozy_user.empty?)
  mozy_users = ['%test_for_tc.19656@emc.com', '%test_for_tc.19808@emc.com', '%test_for_tc.19809@emc.com',
                '%test_for_tc.19815@emc.com', '%17538-test%@test.com', '%17540-test%@test.com', '%17542-test%@test.com',
                '%17543-test%@test.com', '%17544-test%@test.com', '%17546-test%@test.com', '%dev-121960-test1%@test.com',
                '%120019-test%@test.com', '%120021-test%@test.com','%tc121959.user%@mtdev.mozypro.local',
                '%auto%@mtdev.mozypro.local', '%fedid_encoding%@mtdev.mozypro.local', '%tc121965.user%@mtdev.mozypro.local'
  ]
  Log.debug "delete fixed users with username #{mozy_users.join(',')}"
  mozy_users.each {|email| delete_users_by_email(email)}
elsif !mozy_user.nil? && !mozy_user.empty?
  delete_users_by_email(mozy_user)
end

if delete_all || (!ldap_user.nil? && ldap_user.empty?)
  ldap_users = ['%auto%@mtdev.mozypro.local', '%fedid_encoding%@mtdev.mozypro.local', '%tc121965.user%@mtdev.mozypro.local']
  Log.debug "purge fixed users with username #{ldap_users.join(',')}"
  ldap_users.each {|email| purge_users_by_email(email)}
elsif !ldap_user.nil? && !ldap_user.empty?
  purge_users_by_email(ldap_user)
end