require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  include PayloadTestData

  def setup
    gather_data
  end

  def test_payload_request_url
    # require "pry"; binding.pry
    assert_equal 1, PayloadRequest.find(@payload_base.id).url_id
  end

  def test_payload_requested_at
    assert_equal Time,
    PayloadRequest.find(@payload_base.id).requested_at.class

    assert_equal "2013-02-17 04:38:28 UTC",
    PayloadRequest.find(@payload_base.id).requested_at.to_s
  end

  def test_payload_responded_in
    assert_equal 10, PayloadRequest.find(@payload_base.id).responded_in
  end

  def test_payload_referred_by
    assert_equal 1,
    PayloadRequest.find(@payload_base.id).referral_id
  end

  def test_payload_request_type
    assert_equal 1,
    PayloadRequest.find(@payload_base.id).request_type_id
  end

  def test_payload_social_login
    assert_equal 1,
    PayloadRequest.find(@payload_base.id).event_id
  end

  def test_payload_resolution_width
    assert_equal 1,
    PayloadRequest.find(@payload_base.id).resolution_id
  end

  def test_payload_ip
    assert_equal "63.29.38.211",
    PayloadRequest.find(@payload_base.id).ip
  end

  def test_payload_timestamp
    assert_equal Time,
    PayloadRequest.find(@payload_base.id).created_at.class

    assert_equal Time,
    PayloadRequest.find(@payload_base.id).updated_at.class
  end

  def test_payload_validations
    payload = {
      "ip":"120.10.111",
    }
    refute PayloadRequest.new(payload).valid?
  end

  def test_average_response_time
    assert_equal 118.0, PayloadRequest.avg_response_time
  end

  def test_max_response_time
    assert_equal 190, PayloadRequest.max_response_time
  end

  def test_min_response_time
    assert_equal 10, PayloadRequest.min_response_time
  end
end
