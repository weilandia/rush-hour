require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def setup
    @resolution = Resolution.create({resolution_width: "1920", resolution_height: "1280"})

    @request_type = RequestType.create({request_type: "GET"})

    @event = Event.create({event: "socialLogin"})

    @user_agent = UserAgent.create({browser: "Chrome", platform: "Macintosh"})
  end

  def test_request_id
    assert_equal @request_type.id, RequestType.find(@request_type.id).id
  end

  def test_request_name
    assert_equal @request_type.request_type, RequestType.find(@request_type.id).request_type
  end

  def test_top_request_type
    RequestType.create({request_type: "GET"})
    RequestType.create({request_type: "POST"})

    assert_equal "GET", RequestType.top_request_type
  end

  def test_all_request_types
    RequestType.create({request_type: "GET"})
    RequestType.create({request_type: "POST"})
    RequestType.create({request_type: "DELETE"})
    RequestType.create({request_type: "PUT"})

    assert_equal 4, RequestType.all_request_types.count

    assert_equal ["GET", "POST", "DELETE", "PUT"], RequestType.all_request_types
  end

  def test_specific_url_request_types
    request_type = RequestType.create({request_type: "GET"})
    request_type2 = RequestType.create({request_type: "POST"})

    payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":3,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":3,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": request_type2.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    blog = "http://jumpstartlab.com/blog"

    PayloadRequest.create(payload)
    PayloadRequest.create(payload2)
    assert_equal ["GET", "POST"],
    PayloadRequest.url_associated_verbs(blog)
  end

end
