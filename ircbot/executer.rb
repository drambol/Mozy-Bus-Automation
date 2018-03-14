#This is a file to run commands the bot can, but from the command line if you want.
require_relative 'helpers/controller'
include Controller

END { #Put important stuff on top
  define_variables
  run_options
}

#command line tools
def run_options
  require 'optparse'
  # This hash will hold all of the options
  # parsed from the command-line by
  # OptionParser.
  options = {}

  optparse = OptionParser.new do|opts|
    # Set a banner, displayed at the top
    # of the help screen.
    opts.banner = "Usage: executer.rb [option]"

    # Define the options, and what they do
    options[:environmentlist] = false
    opts.on( '-l', '--environmentlist', 'List environment options' ) do
      options[:environmentlist] = true
    end

    options[:environmentchanger] = nil
    opts.on( '-e', '--enviromentchanger ENV', 'Changes the mozy environment' ) do |env|
      options[:environmentchanger] = env
    end

    options[:free] = false
    opts.on( '-f', '--free', 'Creates a MozyFree account and returns credentials' ) do
      options[:free] = true
    end

    options[:pro] = false
    opts.on( '-p', '--pro', 'Creates a MozyPro account/user and returns credentials' ) do
      options[:pro] = true
    end

    options[:update] = false
    opts.on( '-u', '--update', "Does a 'git pull' then 'bundle install'" ) do
      options[:update] = true
    end

    # This displays the help screen, all programs are
    # assumed to have this option.
    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  # Parse the command-line. Remember there are two forms
  # of the parse method. The 'parse' method simply parses
  # ARGV, while the 'parse!' method parses ARGV and removes
  # any options found there, as well as any parameters for
  # the options. What's left is the list of files to resize.
  optparse.parse!

  options_selected = (!!options[:environmentchanger]) || options[:environmentlist] || options[:free] || options[:pro] || options[:update] || options[:test]
  unless options_selected
    puts optparse
    abort
  end

  #puts options

  list_environments if options[:environmentlist]
  change_environment(options[:environmentchanger]) if !!options[:environmentchanger]
  update if options[:update]
  create_free if options[:free]
  create_pro if options[:pro]
end
