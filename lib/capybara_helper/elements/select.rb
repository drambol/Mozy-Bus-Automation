module CapybaraHelper
  module Elements
    module Select
      # Public: Get all options for this select element
      #
      def options
        self.all("option")
      end

      # Public: Get all option's text for this select element
      #
      def options_text
        options.map{ |opt| opt.text}
      end

      # Public: Get all option's values for this select element
      #
      def options_values
        options.map{ |opt| opt.value}
      end

      # Public: Get all selected options for this select element
      #
      #
      # Returns Array<Element>
      def selected_options
        options.select { |e| e.selected? }
      end

      # Public: Get the first selected option in this select element
      #
      def first_selected_option
        option = options.find { |e| e.selected? }
        option or raise "no options are selected"
      end

    end
  end
end