
class Capybara::Session

  alias_method :old_visit, :visit
  def visit(url)
    msg = 'Opening page \'' + url.to_s + '\''
    CapybaraHelper::Extension::Context.instance.log.puts msg if !CapybaraHelper::Extension::Context.instance.log.nil?
    old_visit url
  end
end

