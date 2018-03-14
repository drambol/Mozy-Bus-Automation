When /^I start job migrate to storage pooling for the partner$/ do
  @bus_site.admin_console_page.manage_internal_jobs_section.start_internal_job(@partner_id)
end

# When /^I setup a internal job for parnter (.+) and provide note (.+)$/ do | partner_id, note |
#   @bus_site.admin_console_page.manage_internal_jobs_section.setup_internal_job(partner_id, note)
# end
#
# Then /^I submit a internal job$/ do
#   @bus_site.admin_console_page.manage_internal_jobs_section.submit_internal_job
# end
#
# And /^I wait for the (.+) internal job done$/ do |note|
#   @bus_site.admin_console_page.manage_internal_jobs_section.wait_internal_job_done(note).should == true
# end
