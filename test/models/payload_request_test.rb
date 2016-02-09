require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def setup
    @resolution = Resolution.create({resolution_width: "1920", resolution_height: "1280"})

    @request_type = RequestType.create({request_type: "GET"})

    @event = Event.create({event: "socialLogin"})

    @user_agent = UserAgent.create({browser: "Chrome", platform: "Macintosh"})

    @payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    @payload_request = PayloadRequest.create(@payload)
  end

  def test_payload_request_url
    assert_equal "http://jumpstartlab.com/blog", PayloadRequest.find(@payload_request.id).url
  end

  def test_payload_requested_at
    assert_equal Time,
    PayloadRequest.find(@payload_request.id).requestedAt.class
    assert_equal "2013-02-17 04:38:28 UTC",
    PayloadRequest.find(@payload_request.id).requestedAt.to_s
  end

  def test_payload_responded_in
    assert_equal 37, PayloadRequest.find(@payload_request.id).respondedIn
  end

  def test_payload_referred_by
    assert_equal "http://jumpstartlab.com",
    PayloadRequest.find(@payload_request.id).referredBy
  end

  def test_payload_request_type
    assert_equal @request_type.id,
    PayloadRequest.find(@payload_request.id).request_type_id.to_i
  end

  def test_payload_parameters
    assert_equal "[]",
    PayloadRequest.find(@payload_request.id).parameters
  end

  def test_payload_social_login
    assert_equal @event.id,
    PayloadRequest.find(@payload_request.id).event_id.to_i
  end

  def test_payload_resolution_width
    assert_equal @resolution.id,
    PayloadRequest.find(@payload_request.id).resolution_id.to_i
  end

  def test_payload_ip
    assert_equal "63.29.38.211",
    PayloadRequest.find(@payload_request.id).ip
  end

  def test_payload_timestamp
    assert_equal Time,
    PayloadRequest.find(@payload_request.id).created_at.class

    assert_equal Time,
    PayloadRequest.find(@payload_request.id).updated_at.class
  end

  def test_payload_validations
    payload = {
      "url":"http://jumpstartlab.com/blog",
    }
    refute PayloadRequest.create(payload).valid?

    payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    assert PayloadRequest.create(payload).valid?
  end

  def test_average_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":63,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    PayloadRequest.create(payload2)
    # require 'pry'
    # binding.pry
    assert_equal 50, PayloadRequest.avg_response_time.to_f
  end

  def test_max_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":63,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    PayloadRequest.create(payload2)
    assert_equal 63, PayloadRequest.max_response_time
  end

  def test_min_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":63,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    PayloadRequest.create(payload2)
    assert_equal 37, PayloadRequest.min_response_time
  end

end
