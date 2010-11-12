# Gems
#
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'ruby-debug'
require 'eventmachine'
require 'rack-flash'
require 'dm-validations'
require 'dm-sqlite-adapter'
require 'em-http-request'


# Extensions to Sinatra
#
require File.dirname(__FILE__) + '/ext/partials'
require File.dirname(__FILE__) + '/ext/array_ext'
require File.dirname(__FILE__) + '/ext/reloader'

# Octopus code
#
require File.dirname(__FILE__) + '/octopus'
require File.dirname(__FILE__) + '/octopus/models/subscription'
require File.dirname(__FILE__) + '/octopus/models/net_resource'
require File.dirname(__FILE__) + '/octopus/grabbers/generic_http'

configure :production do
  db = "sqlite3:///#{Dir.pwd}/octopus.sqlite3"
  DataMapper.setup(:default, db)
end

configure :development do
  db = "sqlite3:///#{Dir.pwd}/octopus.sqlite3"
  DataMapper.setup(:default, db)
end

configure :test do
  db = "sqlite3::memory:"
  DataMapper.setup(:default, db)
end

configure :production, :test, :development do
  NetResource.auto_migrate! unless NetResource.storage_exists?
  Subscription.auto_migrate! unless Subscription.storage_exists?
end

configure :production, :development do
  DataMapper.auto_upgrade!
end

# Set the views to the proper path inside the gem
#
set :views, File.dirname(__FILE__) + '/octopus/views'
set :public, File.dirname(__FILE__) + '/octopus/public'

# Register helpers
#
helpers do
  include Sinatra::Partials
  alias_method :h, :escape_html
end

# Set up Rack authentication
#
use Rack::Auth::Basic do |username, password|
  [username, password] == ['admin', 'admin']
end

# Include flash notices
#
use Rack::Session::Cookie
use Rack::Flash

