module SiteHelper
  class Section
    include Capybara::DSL
    include Actions
    extend Components

    attr_reader :root_element

    def initialize(root_element)
      @root_element = root_element
    end

    # Public: Find element by args
    # and highlight element
    #
    # Return Element
    def find(type, locator)
      el = root_element.find(type, locator)
      el.highlight
      el
    end

    # if no this element will return nil. Don't wait.
    def locate(type, locator)
      el = root_element.first(type, locator)
      el.highlight if el
      el
    end

    def all(type, locator, options={})
      root_element.all(type, locator, options)
    end

    def find_link(locator)
      root_element.find_link(locator)
    end

    def locate_link(locator)
      root_element.first(:xpath, XPath::HTML.link(locator))
    end

  end
end
