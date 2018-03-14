# Add extension methods to Capybara::Session class
class Capybara::Session

  # Public: Execute multiline script
  #
  # Example:
  #  page.execute_multiline_script(%{
  #   var changeEvent=document.createEvent('HTMLEvents');
  #   changeEvent.initEvent('change', false, true);
  #   document.getElementById('#{discount_tb.id}').dispatchEvent(changeEvent);
  #  })
  #
  # Returns nothing
  def execute_multiline_script(javascript)
    execute_script("(function(){ #{javascript} })()")
  end

  # Public: Evaluate multiline script
  #
  # Example:
  #   page.evaluate_multiline_script(%{
  #     var foo = document.getElementById('x')
  #     return foo.value
  #   })
  #
  # Returns the javascript result
  def evaluate_multiline_script(javascript)
    evaluate_script("(function(){ #{javascript} })()")
  end

  # Public: Suppress browser alert window with accept or decline
  #
  # Example:
  #   suppress_alert(true)
  #   #=> This will automatic accept alert window
  #
  # Returns nothing
  def suppress_alert(accept=true)
    execute_script("window.confirm = function() { return #{accept}; }")
  end

  # Public: Manually trigger html event
  # This method works on both selenium webdriver and webkit
  #
  # Example:
  #   trigger_html_event(discount_tb.id,'change')
  #
  # Returns nothing
  def trigger_html_event(element_id, event_name)
    evaluate_multiline_script(%{
      var event = document.createEvent('HTMLEvents');
      event.initEvent('#{event_name}', false, true);
      document.getElementById('#{element_id}').dispatchEvent(event);
      return;
    })
  end
end