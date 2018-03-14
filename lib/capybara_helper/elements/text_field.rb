module CapybaraHelper
  module Elements
    module TextField
      # Public: type text into text field
      #
      # Example
      #   element.type_text("hello")
      #
      # Returns nothing
      def type_text(new_value)
        self.clear
        self.set(new_value)
      end

      # Public: append text into text field
      #
      # Example
      #   element.append_text("hello")
      #
      # Returns nothing
      def append_text(new_value)
        old = self.value
        self.set(old + new_value)
      end
    end
  end
end
