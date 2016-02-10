require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'codeclimate-test-reporter'
require 'database_cleaner'

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
    @event2 = Event.create({name: "newsBreaks"})
    @event3 = Event.create({name: "tweet"})

    @user_agent = UserAgent.create({browser: "Chrome", platform: "Macintosh"})
    @user_agent2 = UserAgent.create({browser: "Safari", platform: "Macintosh"})
    @user_agent3 = UserAgent.create({browser: "Mozilla", platform: "Windows"})
    @user_agent4  = UserAgent.create({browser: "Chrome", platform: "Windows"})

    @url_1 = Url.create({path: "http://jumpstartlab.com/blog"})
    @url_2 = Url.create({path: "http://jumpstartlab.com/exam"})
    @url_3 = Url.create({path: "http://jumpstartlab.com/home"})

    @referral_1 = Referral.create({referral_path: "http://jumpstartlab.com/3"})
    @referral_2 = Referral.create({referral_path: "http://jumpstartlab.com/1"})
    @referral_3 = Referral.create({referral_path: "http://jumpstartlab.com/2"})
    @referral_4 = Referral.create({referral_path: "http://jumpstartlab.com/3"})
    @referral_5 = Referral.create({referral_path: "http://jumpstartlab.com/4"})

    @client_1 = Client.create({identifier: "turing", root_url: "http://turing.io"})
    @client_2 = Client.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"})
    @client_3 = Client.create({identifier: "google", root_url: "http://google.com"})

    payload_base = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":10,
      "ip":"63.29.38.211",
      "referral_id": @referral_1.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_2 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":190,
      "ip":"63.29.38.211",
      "referral_id": @referral_3.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_3 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":70,
      "ip":"63.29.38.211",
      "url_id": @url_2.id,
      "referral_id": @referral_3.id,
      "event_id": @event2.id,
      "request_type_id": @request_type.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_4 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_3.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event2.id,
      "user_agent_id": @user_agent2.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_5 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_3.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event2.id,
      "user_agent_id": @user_agent2.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_6 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_3.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent4.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_7 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_3.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_8 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_4.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "user_agent_id": @user_agent4.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_9 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_5.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event3.id,
      "user_agent_id": @user_agent4.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    payload_base_10 = {
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":130,
      "ip":"63.29.38.211",
      "referral_id": @referral_5.id,
      "url_id": @url_1.id,
      "request_type_id": @request_type.id,
      "event_id": @event3.id,
      "user_agent_id": @user_agent4.id,
      "resolution_id": @resolution.id,
      "client_id": @client_2.id
    }

    @payload_base = PayloadRequest.create(payload_base)
    @payload_base_2 = PayloadRequest.create(payload_base_2)
    @payload_base_3 = PayloadRequest.create(payload_base_3)
    @payload_base_4 = PayloadRequest.create(payload_base_4)
    @payload_base_5 = PayloadRequest.create(payload_base_5)
    @payload_base_6 = PayloadRequest.create(payload_base_6)
    @payload_base_7 = PayloadRequest.create(payload_base_7)
    @payload_base_8 = PayloadRequest.create(payload_base_8)
    @payload_base_9 = PayloadRequest.create(payload_base_9)
    @payload_base_10 = PayloadRequest.create(payload_base_10)
  end
end



Capybara.app = RushHour::Server

# class FeatureTest < Minitest::Test
#   include Capybara::DSL
#   include TestHelpers
# end
