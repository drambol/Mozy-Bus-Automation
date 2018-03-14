# Public: Add extension method to Element class
#
class Capybara::Node::Element
  include CapybaraHelper::Elements::Table
  include CapybaraHelper::Elements::Select
  include CapybaraHelper::Elements::TextField
  include CapybaraHelper::Elements::DefinitionList

  # Public: element's id attribute value
  #
  # Returns a string of element's id attribute value

  def id
    self[:id]
  end

  # Public: element's name attribute value
  #
  # Returns a string of element's name attribute value
  def name
    self[:name]
  end

  # Public: Highlight active element
  #
  # Returns nothing
  def highlight
    #begin
      #driver.execute_script("#{self[:style]}; document.activeElement.style.border='2px solid red'")
    #rescue
      # Skipped
    #end
  end
  # Public: clear value of an element
  # This might not work with webkit
  #
  def clear_value
    #On Chrome, execute_script sometimes works sometimes not
    driver.execute_script("document.getElementById('#{self[:id]}').value=''")
    #set('')
  end

  # Public: Get parent element of current element
  #
  # Returns parent element of current element
  def element_parent
    find(:xpath, "..")  #parent::*[1]
  end

  def great_grandparent
    find(:xpath, "../../..")
  end

  # Public: Get next sibling element of current element
  #
  # Returns next sibling element of current element
  def next_sibling
    find(:xpath, "following-sibling::*[1]")
  end

  # Public: Get previous sibling element of current element
  #
  # Returns previous sibling element of current element
  def previous_sibling
    find(:xpath, "preceding-sibling::*[1]")
  end

  # Public: Get all child elements of current element
  #
  # Returns all child elements of current element
  def child
    all(:xpath, "child::*")
  end

  # Public: Get first child element of current element
  #
  # Returns first child element of current element
  def first_child
    find(:xpath, "child::*[1]")
  end

  # Public: Get descendant elements of current element
  #
  # Returns descendant elements of current element
  def descendant
    all(:xpath, "descendant::*")
  end

  # Public: Make CheckBox/RadioButton checked
  #
  # Returns nothing
  def check
    self.click unless checked?
  end

  # Public: Make CheckBox/RadioButton unchecked
  #
  # Returns nothing
  def uncheck
    self.click if checked?
  end

  def clear
    set('')
  end

  def enabled?
    self['disabled'].nil?
  end

  alias_method :old_click, :click
  def click
    msg = 'Clicking on'
    txt = self.text
    val = self.value
    msg += ' text:\'' + txt + '\'' if !txt.nil? && txt.length > 0
    msg += ' value:\'' + val + '\'' if !val.nil? && val.length > 0
    msg += ' ' + @selector.selector.name.to_s + ':' + '\'' + @selector.locator.to_s + '\''
    #puts msg
    CapybaraHelper::Extension::Context.instance.log.puts msg if !CapybaraHelper::Extension::Context.instance.log.nil?
    sleep 1 #pause 1 second before each click to reduce race condition
    old_click
  end

  alias_method :old_set, :set
  def set(value)
    if !value.nil? && value.to_s.length > 0
      is_password = (!self.text.nil? && self.text.downcase.match(/.*password.*/)) ||
          (!self.value.nil? && self.value.downcase.match(/.*password.*/)) ||
          (!@selector.locator.nil? && @selector.locator.to_s.downcase.match(/.*password.*/))
      if is_password
        msg = 'Typing \'******\' in'
      else
        msg = 'Typing \'' + value.to_s + '\' in'
      end

      txt = self.text
      val = self.value
      msg += ' text:\'' + txt + '\'' if !txt.nil? && txt.length > 0
      msg += ' value:\'' + val + '\'' if !val.nil? && val.length > 0
      msg += ' ' + @selector.selector.name.to_s + ':' + '\'' + @selector.locator.to_s + '\''
      #puts msg
      CapybaraHelper::Extension::Context.instance.log.puts msg if !CapybaraHelper::Extension::Context.instance.log.nil?
    end
    old_set value
  end

  alias_method :old_select, :select
  def select(value, options={})
    if !value.nil? && value.to_s.length > 0
      msg = 'Selecting \'' + value.to_s + '\' in'
      val = self.value
      msg += ' value:\'' + val + '\'' if !val.nil? && val.length > 0
      if options.has_key?(:from)
        msg += ' ' + options[:from] + '\''
      else
        msg += ' ' + @selector.selector.name.to_s + ':' + '\'' + @selector.locator.to_s + '\''
      end
      #puts msg
      CapybaraHelper::Extension::Context.instance.log.puts msg if !CapybaraHelper::Extension::Context.instance.log.nil?
    end
    old_select value, options
  end
end

