module OtherHelpers

  def update
    ret = system("cd #{current_cucumber_project}; git pull")
    ret =  ret && system("cd #{current_cucumber_project}; bundle install")
    ret
  end

  def current_cucumber_project
    dir = File.expand_path File.dirname(__FILE__).gsub('\\','/')
    index = dir.split('/').index('bus-web-auto-test')
    File.join(dir.split('/')[0...index+1])
  end

end
