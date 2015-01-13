require 'sinatra/base'
require 'data_mapper'

# is ENV defined? If yes, use directly; if no, call development.
env = ENV['RACK_ENV'] || 'development'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")


require './lib/link'

DataMapper.finalize

DataMapper.auto_upgrade!


class Bookmark < Sinatra::Base
  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do
    url = params["url"]
    title = params["title"]
    Link.create(:url => url, :title => title)
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
