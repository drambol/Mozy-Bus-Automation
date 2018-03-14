module CucumberRunner
  def create_free
    env = get_current_environment('phx')
    cuke_name = "Create and display MozyFree user information"
    run_cucumber(env,cuke_name,'MozyFree')
  end

  def create_pro
    env = get_current_environment('bus')
    if env == 'prod'
      cuke_name = "Create and display PROD MozyPro user information"
    else
      cuke_name = "Create and display MozyPro user information"
    end
    run_cucumber(env,cuke_name,'MozyPro')
  end

  def run_cucumber(env,cuke_name,type)
    str = ''
    cmd = "cd #{current_cucumber_project}; "
    cmd += "export BUS_ENV=#{env}; " unless type == 'MozyFree'
    cmd += "bundle exec cucumber -n \"#{cuke_name}\""
    cuke = `#{cmd}`
    if cuke.include?('Failing Scenarios')
      return "#{type} creation failed"
    end
    cuke.each_line{|line| puts str = "type: #{type}, env: #{env} |#{line.split('INFO -- :')[1]}" if line[0] == 'I' && line.include?('pw:')}
    send_email($prod_emails_to,"Bot - #{type} created in PROD",str) if env == 'prod'
    str
  end
end
