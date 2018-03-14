require 'spec_helper'

describe "Implementation Configuration Modification" do

  describe "self.assign_supp_plan_multi(params)", :vcr do
    it "Assigns multiple supplemental plans to a specified account." do
        params = {"acct_no" => 1, "supp_plan_no" => 1}
	  response = api.assign_supp_plan_multi params

	  response.should have_key("error_code")
	  response.should have_key("proration_result_amount")
        response.should have_key("invoice_no")
        response.should have_key("collection_error_code")
        response.should have_key("collection_error_msg")
        response.should have_key("statement_error_code")
        response.should have_key("statement_error_msg")
        response.should have_key("proc_cvv_response")
        response.should have_key("proc_avs_response")
        response.should have_key("proc_cavv_response")
        response.should have_key("proc_status_code")
        response.should have_key("proc_status_text")
        response.should have_key("proc_payment_id")
        response.should have_key("proc_auth_code")
        response.should have_key("proc_merch_comments")
        response.should have_key("error_msg")
     end
   end

   describe "self.disable_all_standing_usage(params)", :vcr do
     it "Disable all standing_usage rect for given acct_no" do
        params = {"acct_no" => 1}
        response = api.disable_all_standing_usage

        response.should have_key("error_code")
        response.should have_key("error_msg")
     end
   end

   describe "self.disable_standing_usage_by_plan(params)", :vcr do
      it "Disables the standing usage records for a particular plan assigned to an account." do
          params = {"acct_no" => 1, "plan_no" => 1}
          response = api.disable_standing_usage_by_plan params

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.get_acct_tax_exempt_status(params)", :vcr do
      it "Returns an account's tax exemption level(none, federal, state, or both federal and state)." do
          params = {"acct_no" => 1}
          response = api.get_acct_tax_exempt_status params

          response.should have_key("error_code")
          response.should have_key("error_msg")
          response.should have_key("exemption_level")
          response.should have_key("exemption_level_desc")
     end
   end

   describe "self.get_client_items(params)", :vcr do
      it "Returns a list of inventory items associated with a client" do
          response = api.get_client_items

          response.should have_key("client_items")
          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.keep_alive(params)", :vcr do
      it "Increase the given valid session's expiry time by the number of minutes pre-defined for the client" do
          response = api.keep_alive({ "session_id" => 'Test' })

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.kill_session(params)", :vcr do
      it "End a customer's session in a registration or User Self Service application" do
          response = api.kill_session

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.set_acct_tax_exempt_status(params)", :vcr do
      it "Sets the tax exemption level for a specified account" do
          response = api.set_acct_tax_exempt_status({ "acct_no" => 1})

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.set_prov_engine(params)", :vcr do
      it "Specifies whether a client should receive event notification messages" do
          response = api.set_prov_engine

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.set_session(params)", :vcr do
      it "Starts an Aria session for a specified user ID" do
          response = api.set_session

          response.should have_key("error_code")
          response.should have_key("error_msg")
          response.should have_key("session_id")
      end
   end

   describe "self.set_session_auth(params)", :vcr do
      it "Authenticates a customer who logs into a User Self Service application with a user ID and password" do
          response = api.set_session_auth

          response.should have_key("error_code")
          response.should have_key("error_msg")
          response.should have_key("session_id")
      end
   end

   describe "self.subscribe_event(params)", :vcr do
      it "Subscribe a client to a specified event notification" do
          response = api.subscribe_event({ "event_id" => 1 })

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.subscribe_event_class(params)", :vcr do
      it "Subscribe a client to a specified event class" do
          response = api.subscribe_event_class({ "class_no" => 1 })

          response.should have_key("error_code")
          response.should have_key("error_msg")
          response.should have_key("events")
      end
   end

   describe "self.subscribe_events(params)", :vcr do
      it "Subscribe a client to a specified group event notification" do
          response = api.subscribe_events({ "event_list" => '113' })

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.unsubscribe_event(params)", :vcr do
      it "Unubscribe a client from a specified event notification" do
          response = api.unsubscribe_event({ "event_id" => 113 })

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.unsubscribe_event_class(params)", :vcr do
      it "Unubscribe a client from a specified event class" do
          response = api.unsubscribe_event_class({ "class_no" => 113 })

          response.should have_key("error_code")
          response.should have_key("error_msg")
          response.should have_key("events")
      end
   end

   describe "self.unsubscribe_events(params)", :vcr do
      it "Unubscribes a client from a group of specified event notifications" do
          response = api.unsubscribe_events({ "event_list" => '113' })

          response.should have_key("error_code")
          response.should have_key("error_msg")
      end
   end

   describe "self.update_inventory_item_stock_level(params)", :vcr do
      it "Increases or decreases the stock level of a specified inventory item" do
          pending "TODO"
          response = api.update_inventory_item_stock_level
      end
   end

   describe "self.update_master_plan(params)", :vcr do
      it "Changes the master plan assigned to a specified account holder" do
          response = api.update_master_plan({ "acct_no" => 1 })

          response.should have_key("error_code")
          response.should have_key("proration_result_amount")
          response.should have_key("collection_error_code")
          response.should have_key("collection_error_msg")
          response.should have_key("statement_error_code")
          response.should have_key("statement_error_msg")
          response.should have_key("proc_cvv_response")
          response.should have_key("proc_avs_response")
          response.should have_key("proc_cavv_response")
          response.should have_key("proc_status_code")
          response.should have_key("proc_status_text")
          response.should have_key("proc_payment_id")
          response.should have_key("proc_auth_code")
          response.should have_key("proc_merch_comments")
          response.should have_key("invoice_no")
          response.should have_key("cancelled_supp_plans")
          response.should have_key("error_msg")
      end
   end
end