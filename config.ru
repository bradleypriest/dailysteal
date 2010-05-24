require 'toto'
require 'config/environment.rb'

#point to your rails apps /public directory
use Rack::Static, :urls => ['/stylesheets', '/javascripts', '/images',
'/favicon.ico'], :root => 'public'

use Rack::ShowExceptions

use Rack::CommonLogger


#run the toto application

toto = Toto::Server.new do

  #override the default location for the toto directories

  Toto::Paths = {
	:templates => 'blog/templates',
	:pages => 'blog/templates/pages',
	:articles => 'blog/articles'

  }


#set your config variables here
set :title, 'The Daily Steal'
set :date, lambda {|now| now.strftime('%B #{now.day.ordinal} %Y') }
set :summary,   :max => 500
set :root, 'blog'

end


#create a rack app

app = Rack::Builder.new do

  use Rack::CommonLogger


#map requests to /blog to toto
map '/blog' do
run toto
end
#map all the other requests to rails
map '/' do
use Rails::Rack::Static
run ActionController::Dispatcher.new
end
end.to_app


run app