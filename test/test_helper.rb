ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'codeclimate-test-reporter'
require 'simplecov'
require 'coveralls'
require 'database_cleaner'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
])
SimpleCov.start

module TestHelpers

  DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

end



Capybara.app = RushHour::Server

# class FeatureTest < Minitest::Test
#   include Capybara::DSL
#   include TestHelpers
# end
