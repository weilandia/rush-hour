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
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers
  def setup
    DatabaseCleaner.start
  end
  def teardown
    DatabaseCleaner.clean
    super
  end
end

module PayloadTestData
  def gather_data
    @resolution = Resolution.create({width: "1920", height: "1280"})
    @resolution2 = Resolution.create({width: "400", height: "500"})

    @request_type = RequestType.create({verb: "GET"})

    @event = Event.create({name: "socialLogin"})

    @user_agent = UserAgent.create({browser: "Chrome", platform: "Macintosh"})

    @url_1 = Url.create({path: "http://jumpstartlab.com/blog"})
    @url_2 = Url.create({path: "http://jumpstartlab.com/exam"})
    @url_3 = Url.create({path: "http://jumpstartlab.com/home"})

    @referral_1 = Referral.create({referral_path: "http://jumpstartlab.com"})
    @referral_2 = Referral.create({referral_path: "http://jumpstartlab.com/1"})
    @referral_3 = Referral.create({referral_path: "http://jumpstartlab.com/2"})
    @referral_4 = Referral.create({referral_path: "http://jumpstartlab.com/3"})
    @referral_5 = Referral.create({referral_path: "http://jumpstartlab.com/4"})

    payload_base = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":10,
      "ip":"63.29.38.211",
      "referred_by_id": @referral_5.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    payload_base_2 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":190,
      "ip":"63.29.38.211",
      "referred_by_id": @referral_4.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    payload_base_3 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":70,
      "ip":"63.29.38.211",
      "url_id": @url_2.id,
      "referred_by_id": @referral_3.id,
      "event_id": @event.id,
      "request_type_id": @request_type.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    payload_base_4 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referred_by_id": @referral_5.id,
      "url_id": @url_3.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    @payload_base = PayloadRequest.create(payload_base)
    @payload_base_2 = PayloadRequest.create(payload_base_2)
    @payload_base_3 = PayloadRequest.create(payload_base_3)
    @payload_base_4 = PayloadRequest.create(payload_base_4)
  end
end



Capybara.app = RushHour::Server

# class FeatureTest < Minitest::Test
#   include Capybara::DSL
#   include TestHelpers
# end
