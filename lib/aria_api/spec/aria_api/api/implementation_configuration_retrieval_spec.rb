require 'spec_helper'

describe "Implementation Configuration Retrieval" do
  describe "self.clear_reg_uss_config_params(params)", :vcr do
    it "Removes all of the parameter name-value pairs in a specified configuration" do
      response = api.clear_reg_uss_config_params({ "set_name" => 'Test'})

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.clear_reg_uss_params(params)", :vcr do
    it "Removes all of the parameter name-value associated with a particular session ID" do
      response = api.clear_reg_uss_config_params({ "session_id" => 'Test'})

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.client_has_event_class(params)", :vcr do
    it "Indicates whether a client is subcribed to the specified even notification class" do
      response = api.client_has_event_class({ "class_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("response")
    end
  end

  describe "self.delete_reg_uss_config_params(params)", :vcr do
    it "Removes the parameter name-value pairs in a specified configuration" do
      response = api.delete_reg_uss_config_params({ "set_name" => 'Test', "param_name" => 'Test'})

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.delete_reg_uss_params(params)", :vcr do
    it "Removes the parameter name-value pairs in a particular session" do
      response = api.delete_reg_uss_params({ "session_id" => 'Test', "param_name" => 'Test'})

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_acct_groups_by_client(params)", :vcr do
    it "Returns the list of account groups associated with a client" do
      response = api.get_acct_groups_by_client

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("acct_groups")
    end
  end

  describe "self.get_acct_payment_methods(params)", :vcr do
    it "Returns the historical data related to the account's payment methods" do
      response = api.get_acct_payment_methods({ "acct_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("acct_pay_methods")
    end
  end

  describe "self.get_auf_status(params)", :vcr do
    it "Returns the statistics for a specified usage file" do
      response = api.get_auf_status

      response.should have_key("status_cd")
      response.should have_key("load_date_time")
      response.should have_key("recs_received")
      response.should have_key("recs_loaded")
      response.should have_key("recs_failed")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_avail_child_plans_for_plan(params)", :vcr do
    it "Return array of all available child plans subordinate to the given input plan number" do
      response = api.get_avail_child_plans_for_plan({ "in_plan_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("plans")
    end
  end

  describe "self.get_avail_child_plans_for_plan_all(params)", :vcr do
    it "Return all available child plans subordinate to the given input plan number" do
      response = api.get_avail_child_plans_for_plan_all({ "in_plan_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("all_plans")
    end
  end

  describe "self.get_available_plans(params)", :vcr do
    it "Gets selectable plans based on current plan" do
      response = api.get_available_plans({ "acct_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("plans")
    end
  end

  describe "self.get_available_plans_all(params)", :vcr do
    it "Gets selectable plans based on current plan, along with their service and rate schedules" do
      response = api.get_available_plans_all({ "acct_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("all_plans")
    end
  end

  describe "self.get_child_for_item_class(params)", :vcr do
    it "Returns the immediate child classes for that client" do
      response = api.get_child_for_item_class({ "filter_class_no" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("child_item_class")
    end
  end

  describe "self.get_client_countries(params)", :vcr do
    it "return a list of countries assigned to a client" do
      response = api.get_client_countries

      response.should have_key("client_country")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_client_currencies(params)", :vcr do
    it "return a list of currencies assigned to a client" do
      response = api.get_client_currencies

      response.should have_key("client_currency")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_client_plan_service_rates(params)", :vcr do
    it "Return information about the rates for a particular service in a specified plan" do
      response = api.get_client_plan_service_rates({ "plan_no" => 1, "service_no" => 1 })

      response.should have_key("plan_service_rates")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_client_plan_services(params)", :vcr do
    it "Return information about the service in a specified plan" do
      response = api.get_client_plan_services({ "plan_no" => 1 })

      response.should have_key("plan_services")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_client_plans_all(params)", :vcr do
    it "Returns a detailed list of all plans associated with a client" do
      response = api.get_client_plans_all

      response.should have_key("all_client_plans")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_client_plans_basic(params)", :vcr do
    it "Returns a summary list of all plans associated with a client" do
      response = api.get_client_plans_basic

      response.should have_key("plans_basic")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_current_system_version(params)", :vcr do
    it "Returns the current version number of the Aria platform" do
      response = api.get_current_system_version

      response.should have_key("version")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_email_templates(params)", :vcr do
    it "Returns the list of email templates associated with a client" do
      response = api.get_email_templates

      response.should have_key("templates_by_client")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_inv_no_from_bal_xfer(params)", :vcr do
    it "Returns the invoice number associated with a specified balance transfer" do
      response = api.get_inv_no_from_bal_xfer({ "transaction_id" => 1 })

      response.should have_key("invoice_no")
      response.should have_key("acct_no")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_items_by_class(params)", :vcr do
    it "Returns the items for a given class" do
      response = api.get_items_by_class({ "filter_class_no" => 1 })

      response.should have_key("class_items")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_items_by_supp_field(params)", :vcr do
    it "Returns the inventory items associated with a particular value for a supplemental object field" do
      response = api.get_items_by_supp_field({ "field_no" => 1, "field_val" => 1 })

      response.should have_key("items_by_supp_field")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_master_plans_by_supp_field(params)", :vcr do
    it "Returns the master plans associated with a particular value for a supplemental object field" do
      response = api.get_master_plans_by_supp_field({ "field_no" => 1, "field_val" => 1 })

      response.should have_key("master_plans_by_supp_field")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_parent_for_item_class(params)", :vcr do
    it "Returns the immediate parent classes for that client" do
      response = api.get_parent_for_item_class({ "filter_class_no" => 1 })

      response.should have_key("parent_item_class")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_plans_by_promo_code(params)", :vcr do
    it "Returns a summary list of plans associated with a specified promotion code" do
      response = api.get_plans_by_promo_code

      response.should have_key("plans")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_plans_by_promo_code_all(params)", :vcr do
    it "Returns a detailed list of plans associated with a specified promotion code" do
      response = api.get_plans_by_promo_code_all

      response.should have_key("all_plans")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_rate_schedules_for_plan(params)", :vcr do
    it "Returns a list of rate schedules associated with a specified plan" do
      response = api.get_rate_schedules_for_plan({ "plan_no" => 1 })

      response.should have_key("rate_sched")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_reg_uss_config_params(params)", :vcr do
    it "Returns the parameter name-value pairs for a specified configuration" do
      response = api.get_reg_uss_config_params({ "set_name" => 'Test' })

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_reg_uss_params(params)", :vcr do
    it "Returns the parameter name-value pairs for a specified session ID" do
      response = api.get_reg_uss_params({ "session_id" => 1 })

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.get_supp_plans_by_promo_code(params)", :vcr do
    it "Returns a summary list of supplemental plans associated with a specified promotion code" do
      response = api.get_supp_plans_by_promo_code

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("plans")
    end
  end

  describe "self.get_supp_plans_by_promo_code_all(params)", :vcr do
    it "Returns a detailed list of supplemental plans associated with a specified promotion code" do
      response = api.get_supp_plans_by_promo_code_all

      response.should have_key("error_code")
      response.should have_key("error_msg")
      response.should have_key("all_plans")
    end
  end

  describe "self.get_supp_plans_by_supp_field(params)", :vcr do
    it "Returns a list of supplemental plans associated with a specified value for supplemental object field" do
      response = api.get_supp_plans_by_supp_field({ "field_no" => 1, "field_val" => 1 })

      response.should have_key("supp_plans_by_supp_field")
      response.should have_key("error_msg")
      response.should have_key("error_code")
    end
  end

  describe "self.get_top_level_item_class(params)", :vcr do
    it "Returns all the parent classes for that client" do
      response = api.get_top_level_item_class

      response.should have_key("top_item_class")
      response.should have_key("error_msg")
      response.should have_key("error_code")
    end
  end

  describe "self.get_web_replacement_vals(params)", :vcr do
    it "get an array of values for an array of input web replacement strings" do
      response = api.get_web_replacement_vals({"in_replacement_names" => "One|Two"})

      response.should have_key("web_vals_out")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.pre_calc_invoice(params)", :vcr do
    it "Calculates a hypothetical invoice based on geographic data an hypothetical invoice line items" do
      response = api.pre_calc_invoice

      response.should have_key("inv_calc_out")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.replace_reg_uss_config_params(params)", :vcr do
    it "Replaces the parameter name-value pairs in a particular configuration" do
      params = { "set_name" => 'Test', "param_name" => 'Test', "param_val" => 'Test' }
      response = api.replace_reg_uss_config_params params

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.replace_reg_uss_params(params)", :vcr do
    it "Replaces the parameter name-value pairs in a particular session ID" do
      params = { "session_id" => 1, "param_val" => 'Test', "param_name" => 'Test' }
      response = api.replace_reg_uss_params params

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.set_reg_uss_config_params(params)", :vcr do
    it "Creates a configuration set that can be used to customize the global functionality" do
      params = { "set_name" => 'Test', "param_val" => 'Test', "param_name" => 'Test' }
      response = api.set_reg_uss_config_params params

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.set_reg_uss_params(params)", :vcr do
    it "Creates a configuration set that can be used to customize the global functionality" do
      params = { "session_id" => 1, "param_val" => 'Test', "param_name" => 'Test' }
      response = api.set_reg_uss_params params

      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end

  describe "self.validate_session(params)", :vcr do
   it "Determines the validity of a specified session and the user with session ID" do
      response = api.validate_session({"session_id" => '123456'})

      response.should have_key("user_id")
      response.should have_key("account_no")
      response.should have_key("error_code")
      response.should have_key("error_msg")
    end
  end
end