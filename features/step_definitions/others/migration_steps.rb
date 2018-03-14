When /^I migrate (the|multiple) partner to aria$/ do |partners_to_migrate|
#  case partners_to_migrate
#    when 'the'
#      Utility.migrate_partners(@partner_id)
#    when "multiple"
#      Utility.migrate_partners(@partner_id,'123458')
#    else
#  end
  SSHMigration.migrate_to_aria(@partner_id)
end

Given /^I migrate the partner to pooled storage$/ do
  SSHMigration.migrate_to_pooled_storage(@partner_id)
end
