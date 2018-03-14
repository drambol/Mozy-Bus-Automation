module CapybaraHelper
  module Extension
    class Context
      private_class_method :new

      @@ctx = nil
      attr_reader :log

      def initialize
        @log = Log.new
      end

      def Context.instance
        @@ctx = new unless @@ctx
        @@ctx
      end
    end
  end
end
