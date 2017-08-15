require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment',  __FILE__)

require 'ffaker'
require 'rspec/rails'
require 'factory_girl'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'
require 'spree_reffiliate/factories'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::UrlHelpers

  config.infer_spec_type_from_file_location!
  config.mock_with :rspec
  config.color = true
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.fail_fast = ENV['FAIL_FAST'] || false
  config.order = "random"
end
