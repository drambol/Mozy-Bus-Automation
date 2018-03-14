module AriaApi
  class Configuration
    REQUIRED_ATTS = [ :auth_key, :client_no, :url ]

    class << self
      attr_writer *REQUIRED_ATTS
      attr_writer :api_version
    end

    def self.required_attribute(*attributes) # :nodoc:
      attributes.each do |attribute|
        (class << self; self; end).send(:define_method, attribute) do
          attribute_value = instance_variable_get("@#{attribute}")
          raise ConfigurationError.new(attribute.to_s, "needs to be set") unless attribute_value
          attribute_value
        end
      end
    end
    required_attribute *REQUIRED_ATTS

    def self.credentials
      { :auth_key => auth_key, :client_no => client_no }
    end

    def self.api_version
      @api_version ||= "5.15"
    end
  end
end
