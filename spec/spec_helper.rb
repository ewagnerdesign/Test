require 'rubygems'



# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require 'webrat'
gem 'thoughtbot-shoulda'
require 'shoulda'


# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  config.include Webrat::Matchers, :type => :views
#  config.extend ControllerMacros, :type=>:controller


end

# See vendor/plugins/authlogic/lib/authlogic/test_case.rb
#----------------------------------------------------------------------------
def activate_authlogic
  Authlogic::Session::Base.controller = (@request && Authlogic::TestCase::RailsRequestAdapter.new(@request)) || controller
end

# Note: Authentication is NOT ActiveRecord model, so we mock and stub it using RSpec.
#----------------------------------------------------------------------------
def login(user_stubs = {}, session_stubs = {})
  #TODO find by login below should be removed as soon as
  #monitor & investigator fake users removed
#  @current_user = User.find_by_login(user_stubs[:login]) || Factory.build(:user, user_stubs)
  @current_user = Factory.load_or_create(:user, user_stubs)
  @current_user_session = mock_model(UserSession, {:record => @current_user}.merge(session_stubs))
  UserSession.stub!(:find).and_return(@current_user_session)
  @current_user_session.stub!(:user).and_return(@current_user)
end

#----------------------------------------------------------------------------
def login_and_assign(user_stubs = {}, session_stubs = {})
  login(user_stubs, session_stubs)
  assigns[:current_user] = @current_user
end

#----------------------------------------------------------------------------
def logout
  @current_user = nil
  @current_user_session = nil
  UserSession.stub!(:find).and_return(nil)
end

#----------------------------------------------------------------------------
def current_user
  @current_user
end

#----------------------------------------------------------------------------
def current_user_session
  @current_user_session
end

