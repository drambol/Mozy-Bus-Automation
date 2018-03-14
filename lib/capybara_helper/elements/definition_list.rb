module CapybaraHelper
  module Elements
    module DefinitionList

      # Public: All element inside dl tag
      #
      #
      def dl_elements
        self.child
      end

      def dt_dd_elements
        output = []
        sub_array = []
        dl_elements.each do |el|
          case el.tag_name
            when 'dt'
              output << sub_array.dup unless sub_array.empty?
              sub_array.clear
              sub_array << el
            when 'dd'
              sub_array << el
            else
              # Skip
          end
        end
        output << sub_array.dup unless sub_array.empty?
        output
      end

      def dt_dd_elements_text
        dt_dd_elements.map{ |pair| pair.map{ |el| el.text }}
      end

    end
  end
end
