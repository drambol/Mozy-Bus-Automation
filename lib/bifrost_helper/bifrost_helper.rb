$:.unshift(File.dirname(__FILE__))
require 'utils'
require 'user'
require 'machine'
require 'subpartner'
require 'user_group'
require 'api'
require 'rest_client'
require 'json'
require 'time'
require 'logger'
Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG