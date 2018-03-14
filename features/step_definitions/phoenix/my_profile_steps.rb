Then /^I change password in Phoenix from (.+) to (.+)/ do |p1, p2|
  @phoenix_site.update_profile.change_password_in_my_profile(p1, p2)
end

