class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper :all # include all helpers, all the time
  #  attr_accessor :stylesheets
  #  before_filter {|c| c.stylesheets ||= []; c.stylesheets << 'scaffold' }
end
