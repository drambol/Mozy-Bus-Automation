module CapybaraHelper
  module Elements
    # This module parse html table header, body and footer elements
    # Tests: TC.17955, TC.15385, TC.17881, TC.16184
    #
    module Table
      # Raw Capybara::Node::Element of the table
      #
      # Examples:
      #   A html table:
      #   | id | name  |
      #   | 1  | alex  |
      #   | 2  | smith |
      #
      #   gets converted into the following:
      #   #=> [[Element, Element],[Element, Element], [Element, Element]]
      #
      # @return [Array[Array<Capybara::Node::Element>]]
      def raw
        self.all(:css, 'tr').map{ |row| row.all(:css, 'th,td')}
      end

      # Raw text of this table
      # Examples:
      #   A html table:
      #   | id | name  |
      #   | 1  | alex  |
      #   | 2  | smith |
      #
      #   gets converted into the following:
      #   #=> [['id', 'name'],['1', 'alex'], ['2', 'smith']]
      #
      # @return [Array[Array<String>]]
      def raw_text
        raw.map{ |row| row.map{ |cell| cell.text.strip } }
      end

      def has_footer?
        self.all(:css, 'tfoot').size >= 1
      end

      # Elements of table header
      #
      # @return [Array<Capybara::Node::Element>]
      def headers
        th_size = raw.first.select{ |cell| cell.tag_name == 'th'}.size
        case
          when th_size == 1 # vertical header
            raw.map { |cell| cell[0] }
          when th_size > 1 # horizontal header
            raw.first
          else
            nil # no th elements detected
        end
      end

      # Elements of table rows
      #
      # @return [Array[Array<Capybara::Node::Element>]]
      def rows
        th_size = raw.first.select{ |cell| cell.tag_name == 'th'}.size
        r =
          case
            when th_size == 1 # vertical header
              raw.map{ |row| row[1..-1] }.transpose
            when th_size > 1 # horizontal header
              raw[1..-1]
            else  # no header, raw is rows
              raw
          end
        r = r[0..-2] if has_footer?
        r
      end

      # Table headers text
      # Examples:
      #   A html table header with horizontal headers
      #   | id | name |
      #
      #   and
      #
      #   A html table header with vertical headers
      #   | id   |
      #   | name |
      #
      #   get converted into the following:
      #   #=> ['id', 'name']
      #
      # @return [Array<String>]
      def headers_text
        headers.map { |cell| cell.text.strip }
      end

      # Table body rows text
      # Examples:
      #   A html table body with horizontal headers
      #   | 1  | alex  |
      #   | 2  | smith |
      #
      #   and
      #
      #   A html table body with vertical headers
      #   | 1    | 2     |
      #   | alex | smith |
      #
      #   get converted into the following:
      #   #=> [['1', 'alex'], ['2', 'smith']]
      #
      # @return [Array[Array<String>]]
      def rows_text
        rows.map { |row| row.map { |cell| cell.text.strip } }
      end

      # Converts this table into an Array of Hash where the keys of each Hash are the headers in the table.
      # Examples:
      #   A html table:
      #   | id | name  | age |
      #   | 1  | alex  | 10  |
      #   | 2  | smith | 16  |
      #
      #   Gets converted into the following:
      #   # => [{'id' => '1', 'name' => 'alex', 'age' => '10'}, {'id' => '2', 'name' => 'smith', 'age' => '16'}]
      #
      # @return [Array<Hash>]
      def hashes
        rows_text.map{ |row| Hash[*headers_text.zip(row).flatten] }
      end
    end
  end
end
