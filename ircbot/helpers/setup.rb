module Setup

  def setup
    check_install_require('cinch') #bot gem
    check_install('ruby-gmail')
    #check_install_require('open4') #threads
    define_variables
  end

  def define_variables
    require 'yaml'
    $env = YAML.load_file(File.join(File.dirname(__FILE__),'environments.yaml'))
    $recognizer = "#{'#%'*50}\n"
    $windows = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    $prod_emails_to = 'mozybus@gmail.com'
  end

  def bot_help(bot_name)
    help = 'These are my commands:'
    help += "\r- #{bot_name}: list avaliable environments"
    help += "\r- #{bot_name}: create mozyfree user in <environment>"
    help += "\r- #{bot_name}: create mozypro user in <environment>"
    help += "\r- #{bot_name}: status"
    help += "\r- #{bot_name}: help"
    #help += "\n\r- "
    help
  end

  def local_gems
    require 'rubygems'
    Gem::Specification.sort_by{ |g| [g.name.downcase, g.version] }.group_by{ |g| g.name }
  end

  def check_install_require(gem)
    if local_gems[gem].nil?
      puts "This will install the gem: #{gem}"
      `sudo gem install #{gem}`
    end
    require gem
  end

  def check_install(gem)
    if local_gems[gem].nil?
      puts "This will install the gem: #{gem}"
      `sudo gem install #{gem}`
    end
  end

end
