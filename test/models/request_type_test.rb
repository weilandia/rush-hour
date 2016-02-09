require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def setup
    @request_type = RequestType.create({request_type: "GET"})
  end

  def test_request_id
    assert_equal @request_type.id, RequestType.find(@request_type.id).id
  end

  def test_request_name
    assert_equal @request_type.request_type, RequestType.find(@request_type.id).request_type
  end

end
