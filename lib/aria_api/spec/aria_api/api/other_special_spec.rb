require 'spec_helper'

describe "Other-Special" do
	
	describe "self.gen_random_string(params)", :vcr do
		it "generates a random string" do
			params = { "rand_type" => 'A', "rand_length" => 5, "rand_case" => 'U' }
			response = api.gen_random_string params

			response.should have_key("random_string")
			response.should have_key("error_code")
			response.should have_key("error_msg")
		end
	end

	describe "self.get_all_acct_receipt_ids(params)", :vcr do
		it "Returns a list of all client receipt IDs associated with a specified account" do
			params = {"acct_no" => 1}
			response = api.get_all_acct_receipt_ids params

			response.should have_key("error_code")
			response.should have_key("error_msg")
			response.should have_key("acct_receipt")
		end
	end

	describe "self.get_all_actions_by_receipt_id(params)", :vcr do
		it "Returns a list of actions associated with a particular combination of client receipt ID and account" do
			params = {"acct_no" => 1}
			response = api.get_all_actions_by_receipt_id params

			response.should have_key("error_code")
			response.should have_key("error_msg")
			response.should have_key("receipt_action")
		end
	end

	describe "self.get_all_client_receipt_ids(params)", :vcr do
		it "Returns a list of all client receipt IDs entered as input parameters for any API call to Aria." do
			response = api.get_all_client_receipt_ids

			response.should have_key("error_code")
			response.should have_key("error_msg")
			response.should have_key("client_receipt")
		end
	end

	describe "self.init_paypal_bill_agreement(params)", :vcr do
		it "Creates a session with PayPal so that a customer can set up a billing agreement" do
			params = {"acct_no" => 1}
			response = api.init_paypal_bill_agreement params

			response.should have_key("error_code")
			response.should have_key("error_msg")
		end  
	end

	describe "self.save_paypal_bill_agreement(params)", :vcr do
		it "Confirms that a billing agreement has been accepted by a specified account holder and that PayPal is ablo to authorize a payment based on that billing agreement." do
			params = {"acct_no" => 1, "token" => "test"}
			response = api.save_paypal_bill_agreement params

			response.should have_key("error_code")
			response.should have_key("error_msg")
		end
	end

	describe "self.toggle_test_account(params)", :vcr do
	 	it "Changes a specified account from a live account to a test account or from a test account to a live account." do
	 		params = {"account_no" => 1}
	 		response = api.toggle_test_account params

	 		response.should have_key("error_code")  
	 		response.should have_key("error_msg")
	 	end
	end
end
