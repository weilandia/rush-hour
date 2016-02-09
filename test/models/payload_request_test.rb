require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test

  def setup
    @payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
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
    assert_equal "GET",
    PayloadRequest.find(@payload_request.id).requestType
  end

  def test_payload_parameters
    assert_equal "[]",
    PayloadRequest.find(@payload_request.id).parameters
  end

  def test_payload_social_login
    assert_equal "socialLogin",
    PayloadRequest.find(@payload_request.id).eventName
  end

  def test_payload_user_agent
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    PayloadRequest.find(@payload_request.id).userAgent
  end

  def test_payload_resolution_width
    assert_equal "1920",
    PayloadRequest.find(@payload_request.id).resolutionWidth
  end

  def test_payload_resolution_heigh
    assert_equal "1280",
    PayloadRequest.find(@payload_request.id).resolutionHeight
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
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }

    assert PayloadRequest.create(payload).valid?
  end
end
