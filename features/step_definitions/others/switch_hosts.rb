And /^I switch hosts to (blue|green)(| and act as newly created partner| and act as newly created subpartner| without login bus)$/ do |env, action|
  if is_blue_green_test
    current = get_current_env
    target = {'color' => env, 'hosts' => ENV[env.upcase]}

    target_hosts_file = target['hosts']+'.hosts'
    Utility.replace_hosts_file(target_hosts_file)
    if defined?@bus_site
      @bus_site.login_page.clear_cache

      #print switch logs
      msg = "\n" + "#"*33 + "\n##    SWITCH BLUE/GREEN ENV    ##\n"+ "#"*33
      Log.debug(msg)
      @bus_site.log(msg)
      msg = current['color'].upcase + ' ' + current['hosts']\
            + ' ==> ' \
            + target['color'].upcase + ' ' + target['hosts']
      Log.debug(msg)
      @bus_site.log(msg)
    end
    sleep(1)
  end

  if action == ' and act as newly created partner'
    step %{I log in bus admin console as administrator}
    step %{I search partner by newly created partner admin email}
    step %{I view partner details by newly created partner company name}
    step %{I act as newly created partner account}
  elsif action == ' and act as newly created subpartner'
    step %{I log in bus admin console as administrator}
    step %{I search partner by newly created subpartner admin email}
    step %{I view partner details by newly created subpartner company name}
    step %{I act as newly created partner account}
  elsif action == ''
    step %{I log in bus admin console as administrator}
  end
end