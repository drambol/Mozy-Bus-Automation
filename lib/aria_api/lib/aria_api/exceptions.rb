module AriaApi

  # Super class for all AriaApi exceptions.
  class AriaApiError < ::StandardError; end

  class ConfigurationError < AriaApiError
    def initialize(setting, message) # :nodoc:
      super "AriaApi::Configuration.#{setting} #{message}"
    end
  end

end
