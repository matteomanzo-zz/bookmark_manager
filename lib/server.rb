require 'data_mapper'

# is ENV defined? If yes, use directly; if no, call development.
env = ENV['RACK_ENV'] || 'development'

DataMapper::Logger.new($stdout, :debug)


DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")


require './lib/link'

DataMapper.finalize

DataMapper.auto_upgrade!