module CapybaraHelper
  module Extension
    class Log
      attr_writer :dest

      def puts(msg)
        @dest.puts msg
      end
    end
  end
end
