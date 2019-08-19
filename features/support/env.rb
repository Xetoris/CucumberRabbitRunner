require 'capybara/cucumber'
require 'rspec/expectations'
require_relative '../../controls/controls'


Capybara.register_driver :example do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :example