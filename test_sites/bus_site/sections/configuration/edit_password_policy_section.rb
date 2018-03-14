# encoding: utf-8
module Bus
  # This class provides actions for edit password policy
  class EditPasswordPolicySection < SiteHelper::Section

    element(:save_changes_btn, xpath: "//div[contains(@id,'password_policy')]//input[@value='Save Changes']")
    element(:message_li, xpath: "//div[@id='setting-edit_password_policy-errors']/ul/li")

    #user password policy section
    element(:user_policy_type_inherit_input, id: "user_policy_type_inherit")
    element(:user_policy_type_custom_input, id: "user_policy_type_custom")
    #custom user password policy section
    element(:user_policy_min_length_input, id: "user_policy_min_length")
    element(:user_policy_min_character_classes, id: "user_policy_min_character_classes")
    element(:user_complexity_radio2_input, xpath: "//div[2]/div[2]/label/input[@id='user_policy[all_classes][all]']")
    element(:user_max_failure_per_username_input, xpath: "//input[@id='user_policy_max_failures_per_username']")
    element(:user_failure_period_per_username_input, xpath: "//input[@id='user_policy_failure_period_per_username']" )
    element(:user_lockout_duration_per_username_input, xpath: "//input[@id='user_policy_lockout_duration_per_username']")

    #admin password policy section
    element(:same_policy_input, id: "same_policy")
    element(:admin_policy_type_inherit_input, id: "admin_policy_type_inherit")
    element(:admin_policy_type_custom_input, id: "admin_policy_type_custom")
    #custom admin password policy section
    element(:admin_policy_min_length_input, id: "admin_policy_min_length")
    element(:admin_policy_min_character_classes, id: "admin_policy_min_character_classes")
    element(:admin_complexity_radio2_input, xpath: "//div[2]/div[2]/label/input[@id='admin_policy[all_classes][all]']")

    element(:user_policy_max_age_input, id: "user_policy_max_age_days")

    # Public: edit user's password policy
    #
    # Example
    #  @bus_site.admin_console_page.edit_password_policy_section.edit_user_password_policy(@password_policy)
    #
    def edit_user_password_policy(policy_table)
      if policy_table.user_policy_type == 'default'
        user_policy_type_inherit_input.check
      else
        user_policy_type_custom_input.check
        user_policy_min_length_input.type_text policy_table.user_policy_min_length unless policy_table.user_policy_min_length.nil?
        if !policy_table.user_min_character_classes.nil?
          user_complexity_radio2_input.check
          user_policy_min_character_classes.type_text policy_table.user_min_character_classes
        end
        if !policy_table.user_character_classes.nil?
          character_classes = ['Capital letters','Lowercase letters','Numbers','Special characters']
          character_classes.each do |classes|
            if policy_table.user_character_classes.include?(classes)
              Log.debug("Processing grant character class #{classes} to policy")
              find(:xpath, "//fieldset[@id='user_policy_form']//label[text()='#{classes}']/input").check
            else
              find(:xpath, "//fieldset[@id='user_policy_form']//label[text()='#{classes}']/input").uncheck
            end
          end
        end

        if !policy_table.user_max_failure_per_username.nil?
          user_max_failure_per_username_input.type_text policy_table.user_max_failure_per_username
        end
        if !policy_table.user_failure_period_per_username.nil?
          user_failure_period_per_username_input.type_text policy_table.user_failure_period_per_username
        end
        if !policy_table.user_lockout_duration_per_username.nil?
          user_lockout_duration_per_username_input.type_text policy_table.user_lockout_duration_per_username
        end

        ##continue to add inputs here

      end
    end

    def verify_user_password_policy(policy_table)
      if policy_table.user_policy_type == 'default'
        user_policy_type_inherit_input.checked?.should == true
      else
        user_policy_type_custom_input.checked?.should == true
        if !policy_table.user_min_character_classes.nil?
          user_complexity_radio2_input.checked?.should == true
          # user_policy_min_character_classes.value.should == policy_table.user_min_character_classes
        end
        if !policy_table.user_character_classes.nil?
          character_classes = ['Capital letters','Lowercase letters','Numbers','Special characters']
          character_classes.each do |classes|
            if policy_table.user_character_classes.include?(classes)
              Log.debug("Processing grant character class #{classes} to policy")
              find(:xpath, "//fieldset[@id='user_policy_form']//label[text()='#{classes}']/input").checked?.should == true
            else
              find(:xpath, "//fieldset[@id='user_policy_form']//label[text()='#{classes}']/input").checked?.should == false
            end
          end
        end
      end
    end

    def edit_admin_password_policy(policy_table)
      if policy_table.admin_user_same_policy.upcase == 'YES'
        same_policy_input.check
      else
        same_policy_input.uncheck
        if policy_table.admin_policy_type == 'default'
          admin_policy_type_inherit_input.check
        else
          admin_policy_type_custom_input.check
          admin_policy_min_length_input.type_text policy_table.admin_policy_min_length unless policy_table.admin_policy_min_length.nil?
          if !policy_table.admin_min_character_classes.nil?
            admin_complexity_radio2_input.check
            admin_policy_min_character_classes.type_text policy_table.admin_min_character_classes
          end
          if !policy_table.admin_character_classes.nil?
            character_classes = ['Capital letters','Lowercase letters','Numbers','Special characters']
            character_classes.each do |classes|
              if policy_table.admin_character_classes.include?(classes)
                Log.debug("Processing grant character class #{classes} to policy")
                find(:xpath, "//fieldset[@id='admin_policy_form']//label[text()='#{classes}']/input").check
              else
                find(:xpath, "//fieldset[@id='admin_policy_form']//label[text()='#{classes}']/input").uncheck
              end
            end
          end

          ##continue to add inputs here

        end
      end
    end

    def save_policy
      save_changes_btn.click
    end

    def message
      message_li.text
    end

    def update_max_age(days)
      find(:xpath, "//input[@id='user_policy_type_custom']").check
      if days.eql?('unlimited')
        user_policy_max_age_input.clear
      else
        user_policy_max_age_input.type_text(days)
      end
    end

    def is_admin_same_as_user_policy
      same_policy_input.checked?
    end
  end
end
