module Phoenix
  class ChangeProfilePage < SiteHelper::Page

  # editing profile section
  # items relating to editing a user's profile
  element(:message_text, css: "p.notice")
  element(:message_profile, xpath: "//div[@id='maincontent']/p")
  # change user name
  element(:user_name_tb, id: "user_name")
  # delete account section
  element(:password_tb, id: "password")
  element(:delete_account_btn, xpath: "//input[@id='delete_account']")
  # change password section
  element(:old_pw, id: "old_password")
  element(:new_pw, id: "new_password")
  element(:new_pw2, id: "new_password2")
  element(:change_btn, css: "input.ui-button")
  # cc change submit button
  element(:change_submit_btn, id: "submit_button")
  # change credit card and country
  element(:profile_country_ccc, id: "user_country")
  element(:change_cc_country_submit_btn, css: "input.img-button")
  element(:change_cc_and_country_link, css: "p.error a")

  # change profile country
  element(:profile_country, xpath: "//select[@name='user[country]']")
  element(:profile_country_error_text, css: "p.error")

  # items relating to changing the account
  element(:change_plan_select, id: "consumer_plan_id")
  element(:change_quota_tb, id: "num_quota_buckets")
  element(:change_machines_select, id: "machines")
  element(:change_period_select, id: "period")
  element(:payment_confirm, css: "div.inner-center-form-box > p")
  element(:upgrade_continue_btn, xpath: "//div[@id='maincontent']//input[@name='submit']")
  element(:upgrade_last_continue_btn, xpath: "//div[@id='maincontent']//input[@type='submit']")

  # items in the Payment Details page during change current plan
  elements(:curplan_payment_details_tb, xpath: "//table[@class='subscription_summary']")
  element(:upgrade_submit_btn, xpath: "//input[@id='submit_button']")
  element(:prorated_cost_text, xpath: "//form[@id='update_finish_form']/p/b")

  # my plan page elements
  element(:my_plan_title, xpath: "//div[@id='maincontent']//h2")
  element(:curplan_summary_tb, xpath: "//div[@id='maincontent']/div/table//td[1]/table")
  element(:renewal_plan_summary_tb, xpath: "//div[@id='maincontent']/div/table//td[2]/table")
  element(:renewal_plan_same_as_div, xpath: "//div[@id='maincontent']//table//td[2]/table//tr[2]//div")

  # during change renewal plan the table of renewal plan summary
  element(:renewal_plan_subscription_tbl, xpath: "//form[@id='update_renewal_form']/table[1]")
  element(:renewal_plan_submit_btn, xpath: "//form[@id='update_renewal_form']//input[@type='submit']")

  # upgrade home free user to paid
  element(:free2paid_country_name, xpath: "//input[@id='user_name']")
  element(:free2paid_country_select, xpath: "//select[@name='user[country]']")
  element(:free2paid_continue_btn, xpath: "//input[@id='conti_button']")
  element(:update_profile_country_upgrade_link, css: "p.error a")
  element(:continue_btn, css: "input.img-button")

  #change password
  element(:change_password_btn, xpath: "//h3[text()='Password:']/../following-sibling::td/span/a[text()='change']")
  element(:old_password_tb, id: "old_password")
  element(:new_password_tb, id: "new_password")
  element(:new_password_again, id: "new_password2")
  element(:submit_change_password_btn, xpath: "//input[@value='Change Password']")



  #--delete user section--
  # calls the whole process
  def delete_account(password)
    delete_account_link
    password_tb.type_text(password)
    delete_account_btn.click
  end

  def delete_account_link()
    find(:xpath, "//a[contains(@href,'/account/cancel_verify')]").click
  end

  #--change credit card and country section--
  def change_cc_and_country(partner)
    change_cc_and_country_link.click
    profile_country_ccc.select(partner.company_info.country)
    change_cc_country_submit_btn.click
    # code for filling in payment info in cybersource page
    @orther_site = OtherSites.new
    @orther_site.cybersource_page.fill_billing_info(partner)
  end

  #--change credit card information section--
  # calls the whole process
  def change_cc(partner)
    change_cc_link
    change_cc_entry(partner)
  end

  # change cc link click
  def change_cc_link
    find(:xpath, "//a[contains(@href,'/account/change_credit_card')]").click
  end

  # change cc info script
  def change_cc_entry(partner)
    continue_btn.click

    # code for filling in payment info in cybersource page
    @orther_site = OtherSites.new
    @orther_site.cybersource_page.fill_billing_info(partner)

  end

  # cc changed successfully
  def cc_changed?(partner)
    cc_type = (partner.credit_card.type == 'Maestro UK')? 'credit card' : partner.credit_card.type
    Log.debug message_text.text
    message_text.text.include?("#{partner.credit_card.last_four_digits}").should == true
  end

  # change profile country in account/profile page
  def change_profile_country(partner)
    profile_country.select(partner.company_info.country)
    change_btn.click
  end

  def profile_changed?
    message_profile.eql?("Profile saved.")
  end

  def profile_error_message
    profile_country_error_text.text
  end

  #--change password section--
  # calls the whole process
  def change_password
    change_pw_link
    change_pw_entry
  end

  # change password link click
  def change_pw_link
    find(:xpath, "//a[contains(@href,'/account/password')]").click
  end

  # change password script
  def change_pw_entry
    old_pw.type_text(CONFIGS['global']['test_pwd'])
    new_pw.type_text(QA_ENV['bus_password'])
    new_pw2.type_text(QA_ENV['bus_password'])
    change_btn.click
    message_text.eql?("Your password was changed.")
  end

  # changing user profile addressing data
  def change_user_name(partner)
    user_name_tb.type_text(partner.admin_info.full_name)
    change_btn.click
    message_profile.eql?("Profile saved.")
  end

  def click_my_plan_link
    find(:xpath, "//ul[@class='side-menu']//a[contains(@href,'plan')]").click if all(:xpath,"//ul[@class='side-menu']//a[contains(@href,'plan')]").size > 0
  end

  #--change plan section
  #--methods here are for changing plan specifics (GB, Adding Machines/Storage, Billing Cycle)
  # change plan - current
  def change_plan_current(partner, new_base_plan, new_additional_storage, new_additional_computers)
    change_plan_current_before_confirm(partner, new_base_plan, new_additional_storage, new_additional_computers)
    partner.curplan_payment_summary = curplan_payment_details_tb_rows
    upgrade_submit_btn.click
    payment_confirm.present?
    upgrade_last_continue_btn.click
  end

  def change_plan_current_before_confirm(partner, new_base_plan, new_additional_storage, new_additional_computers)
    click_my_plan_link
    find(:xpath, "//a[contains(@href,'/plan/edit')]").click
    if !new_base_plan.nil?
      change_plan_select.select("MozyHome #{new_base_plan}") unless new_base_plan.empty?
    end
    fill_addl_quota(new_additional_storage) unless new_additional_storage.nil?
    fill_addl_mach(new_additional_computers) unless new_additional_computers.nil?
    # current plan's billing cycle is fixed
    upgrade_continue_btn.click
  end

  # change plan - future
  def change_plan_future(new_base_plan, new_additional_storage, total_computers, new_subscription, submit = false)
    click_my_plan_link
    find(:xpath, "//a[contains(@href,'/plan/edit_renewal')]").click
    if !new_base_plan.nil?
      change_plan_select.select("MozyHome #{new_base_plan}") unless new_base_plan.empty?
    end
    fill_addl_quota(new_additional_storage) unless new_additional_storage.nil?
    fill_addl_mach(total_computers) unless total_computers.nil?
    period_fill_out(new_subscription)
    renewal_plan_submit_btn.click if submit
  end

  # click 'Submit' button during renewal plan
  def submit_renewal_plan()
    # get base plan value
    base_plan_value = find(:xpath, "//select[@id='consumer_plan_id']").find('option[selected]').text
    gb_value = find(:xpath, "//select[@id='consumer_plan_id']").value
    gb_value_selected = find(:xpath, "//select[@id='consumer_plan_id']//option[@value='"+gb_value.to_s+"']").text.include?('125')?'125':'50'
    base_plan = base_plan_value.gsub(/125|50/, gb_value_selected)
    # get Computers value
    computers = find(:xpath, "//select[@id='machines']").value
    # get Subscription value
    subscription_value = find(:xpath, "//select[@id='period']").value
    subscription = find(:xpath, "//select[@id='period']/option[@value='#{subscription_value}']").text
    # get additional storage default value
    addl_storage = find(:xpath, "//input[@id='num_quota_buckets']").value
    array = renewal_plan_subscription_tbl.raw_text
    array[0][1] = base_plan
    array[1][1] = addl_storage + " " + array[1][1]
    array[3][1] = computers
    array[4][1] = subscription
    array.delete_at array.index(["",""]) unless array.index(["",""]).nil?
    renewal_plan_submit_btn.click
    array
  end

  def fill_addl_quota(additional_storage)
    change_quota_tb.clear_value
    if additional_storage.eql?("max")
      change_quota_tb.type_text("99")
    else
      change_quota_tb.type_text(additional_storage)
    end
    find(:xpath, "//td[@id='num_quota_total']").click
    sleep 2
  end

  def fill_addl_mach(additional_computers)
    change_machines_select.select(additional_computers)
  end

  def period_fill_out(subscription_period)
    # for other language e.g. FR, the option text is not Monthly, Yearly,Biennial
    change_period_select.find("option[value='#{subscription_period}']").click unless subscription_period.nil?
     # case subscription_period
      #    when "M"
      #      change_period_select.select("Monthly")
      #    when "Y"
      #      change_period_select.select("Yearly")
      #    when "2"
      #      change_period_select.select("Biennial")
      #  end
 end

  # the Payment Details information during change current plan
  def  curplan_payment_details_tb_rows
    wait_until{curplan_payment_details_tb[0].visible?}
    new_array = Array.new
    curplan_payment_details_tb.each do |table|
      array = table.raw_text
      array.delete_at 0
      new_array = new_array + array
    end
    new_array
  end

  # current plan information in my plan page
  def  curplan_summary_tb_rows
    click_my_plan_link
    wait_until{curplan_summary_tb.visible?}
    array = curplan_summary_tb.raw_text
    array.delete_at 0
    array
  end

  # renewal  plany information in my plan page
  def  renewal_plan_summary_tb_rows
    wait_until{renewal_plan_summary_tb.visible?}
    array = renewal_plan_summary_tb.raw_text
    array.delete_at 0
    array
  end

  def  renewal_plan_same_as_message
    wait_until{renewal_plan_same_as_div.visible?}
    renewal_plan_same_as_div.text
  end

  def get_prorated_cost
    prorated_cost_text.text
  end

  def select_country_free_paid(partner, profile_country)
    free2paid_country_name.type_text(partner.admin_info.full_name)
    free2paid_country_select.select(partner.company_info.country) if profile_country.nil?
    free2paid_continue_btn.click
  end

  def get_my_plan_title
    my_plan_title.text
  end

  def decrease_error_msg
    find(:xpath, "//div[@id='maincontent']/div[1]/p").text
  end

  def click_cancel_change_curplan
    find(:xpath, "//div[@id='maincontent']//input[@name='cancel']").click
  end

  def update_profile_country_upgrade(profile_country)
    update_profile_country_upgrade_link.click
    free2paid_country_select.select(profile_country)
    free2paid_continue_btn.click
    continue_btn.click
  end

  def change_password_in_my_profile (old_password, new_password)
    change_password_btn.click
    wait_until{old_password_tb.visible?}
    old_password_tb.type_text(old_password)
    new_password_tb.type_text(new_password)
    new_password_again.type_text(new_password)
    submit_change_password_btn.click
  end

  end
end
