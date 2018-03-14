require_relative 'helpers/controller'
include Controller

$nick = 'jarvis'
$busy = nil;
END {
  setup
  run_bot
}

def run_bot
  bot = Cinch::Bot.new do
    $status = "Being Awesome!"
    $jobs = []
    configure do |c|
        c.server = "irc.mozycorp.com"
        c.port = 6697
        c.ssl.use = 'true'
        c.nick = $nick
        c.realname = 'Bus Bot'
        c.channels = ["#deploy",'#bus']
    end

    on :channel, /#{$nick}: hey/ do |m|
      m.reply "Hey #{m.user}"
      m.reply $nick
    end

    on :channel, /^#{$nick}: echo (([^;])+)/ do |m, match|
      m.reply match
    end

    on :channel, /#{$nick}: list avaliable environments/ do |m|
      m.reply list_environments
    end

    on :channel, /#{$nick}: help/ do |m|
      m.reply bot_help($nick)
    end

    on :channel, /#{$nick}: status/ do |m|
      return m.reply "Not busy" if $busy.nil?
      m.reply $busy
    end

    on :channel, /#{$nick}: create (.*) user in (.*)/ do |m,type,env|
      return m.reply "Sorry, #{$busy}" unless $busy.nil?

      unless valid_environment?(env)
        return m.reply "'#{type}' is not a valid environment"
      end

      $busy = "I am making a #{type} user in #{env} for #{m.user}"
      case type
      when 'mozyfree','free'
        m.reply "This will make a mozyfree user in #{env}"
        change_environment(env)
        m.reply create_free
      when 'mozypro','pro'
        m.reply "This will make a mozypro user in #{env}"
        change_environment(env)
        m.reply create_pro
      else
        return m.reply "'#{type}' is not a valid type"
      end
      $busy = nil
    end

    #on :channel, /#{$nick}: update/ do |m|
    #  m.reply 'Updating bus-web-auto-test'
    #  m.reply "Updating #{update ? 'passed' : 'failed'}"
    #end

  end
  bot.start
end
