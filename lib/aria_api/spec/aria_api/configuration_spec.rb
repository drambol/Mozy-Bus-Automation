require 'spec_helper'

describe AriaApi::Configuration do

  describe "self.auth_key" do
    it "raises an exception if it hasn't been set yet" do
      conf.instance_variable_set(:@auth_key, nil)

      expect {
        conf.auth_key
      }.to raise_error(AriaApi::ConfigurationError, "AriaApi::Configuration.auth_key needs to be set")
    end
  end

  describe "self.client_no" do
    it "raises an exception if it hasn't been set yet" do
      conf.instance_variable_set(:@client_no, nil)

      expect {
        conf.client_no
      }.to raise_error(AriaApi::ConfigurationError, "AriaApi::Configuration.client_no needs to be set")
    end
  end


  describe "self.url" do
    it "raises an exception if it hasn't been set yet" do
      conf.instance_variable_set(:@url, nil)

      expect {
        conf.url
      }.to raise_error(AriaApi::ConfigurationError, "AriaApi::Configuration.url needs to be set")
    end
  end

  describe "self.credentials" do
    it "returns a hash of :auth_key and :auth_key" do
      conf.auth_key = "1234"
      conf.client_no = "5678"
      conf.credentials.should == { :auth_key => "1234", :client_no => "5678" }
    end
  end

  describe "self.api_version" do
    it "returns 5.15 by default" do
      conf.api_version.should == "5.15"
    end

    it "can be overridden" do
      conf.api_version = "5.16"
      conf.api_version.should == "5.16"
    end
  end

  def conf
    AriaApi::Configuration
  end

  after(:all) do
    SupportSpecHelper.use_development_credentials
  end

end
