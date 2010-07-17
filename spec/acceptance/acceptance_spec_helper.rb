require File.dirname(__FILE__) + '/../trovare_spec_helper'
require "selenium/client"
#require "selenium/rspec/spec_helper"


class Selenium::Client::Driver
  def wait_for_ajax(timeout=5000)
    js_condition = "selenium.browserbot.getCurrentWindow().jQuery.active == 0"
    wait_for_condition(js_condition, timeout)
  end

  def ajax action
    click action
    wait_for_ajax
  end

  def goto action
    click action
    wait_for_page_to_load
  end

  def confirm
    res = get_confirmation()
    sleep 1
    res
  end
end

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = false
end

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.deliveries = []


module AcceptanceSpecHelper
  include TrovareSpecHelper

  attr_reader :verification_errors

  def browser
    unless @browser
      @browser ||= Selenium::Client::Driver.new(
        :host => "localhost",
        :port => 4444,
#        :browser => "*firefox /usr/lib/firefox-3.6.5pre/firefox-bin",
        :browser => "*firefox /usr/lib/firefox-3.5.9/firefox",
        :url => "http://localhost:3000",
        :timeout_in_second => 90
#        :javascript_framework => :jquery,
#        :highlight_located_element => true
      )
    end

    @browser
  end

  def self.included(base)
    base.before(:each) do
      clean_db
      browser.start_new_browser_session

      browser.open "/"   
      browser.type :user_session_login, "admin"
      browser.type :user_session_password, "admin_1234"
      browser.goto :user_session_submit
    end

    base.after(:each) do
      browser.close_current_browser_session
    end
  end

end

Dir.glob('spec/acceptance/shared/*.rb').each do |shared_example|
  require shared_example
end
