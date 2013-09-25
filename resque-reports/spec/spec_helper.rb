# -*- encoding : utf-8 -*-
# - Sort through your spec_helper file. Place as much environment loading
#   code that you don't normally modify during development in the
#   Spork.prefork block.
# - Place the rest under Spork.each_run block
# - Any code that is left outside of the blocks will be ran during preforking
#   and during each_run!
# - These instructions should self-destruct in 10 seconds.  If they don't,
#   feel free to delete them.
require 'spork'

Spork.prefork do
  require 'active_support'
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RAILS_ENV'] ||= 'test'

  FileUtils.cp(File.expand_path('../../../../../config/sphinx.yml', __FILE__), File.expand_path('../dummy/config/sphinx.yml', __FILE__))

  require File.expand_path('../dummy/config/application', __FILE__)
  require "#{Rails.application.paths.vendor.plugins.first}/core_domains/lib/core/domains/testing/test_helper"
  require File.expand_path('../dummy/config/environment', __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl'
  require 'shoulda-matchers'
  require 'capybara/rails'
  require 'capybara/rspec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
  Dir["#{Rails.application.paths.vendor.plugins.first}/core/spec/support/**/*.rb"].each { |f| require f }
  Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each { |f| require f }

  use_plugin_support
  use_plugin_factories

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{File.dirname(__FILE__)}/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    if ENV['CI'].present?
      config.color_enabled = true
      config.tty = true
      config.formatter = :documentation
    end

    config.backtrace_clean_patterns = []
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
end
