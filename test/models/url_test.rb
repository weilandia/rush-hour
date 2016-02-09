require_relative "../test_helper"

class UrlTest < Minitest::Test
  def test_specific_url_max_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":3,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    payload3 = {
      "url":"http://jumpstartlab.com/exam",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":100,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    blog = "http://jumpstartlab.com/blog"
    exam = "http://jumpstartlab.com/exam"

    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)

    assert_equal 37, PayloadRequest.url_max_response_time(blog)

    assert_equal 100,
    PayloadRequest.url_max_response_time(exam)
  end

  def test_specific_url_min_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":3,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    payload3 = {
      "url":"http://jumpstartlab.com/exam",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":100,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    blog = "http://jumpstartlab.com/blog"
    exam = "http://jumpstartlab.com/exam"

    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)

    assert_equal 3, PayloadRequest.url_min_response_time(blog)

    assert_equal 100,
    PayloadRequest.url_min_response_time(exam)
  end

  def test_specific_url_ordered_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":3,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }
    payload3 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":100,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    blog = "http://jumpstartlab.com/blog"

    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)


    assert_equal [100, 37, 3],
    PayloadRequest.url_response_times_ordered(blog).map(&:respondedIn)
  end

  def test_specific_url_avg_response_time
    payload2 = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":3,
      "referredBy":"http://jumpstartlab.com",
      "parameters":[],
      "ip":"63.29.38.211",
      "request_type_id": @request_type.id,
      "event_id": @event.id,
      "user_agent_id": @user_agent.id,
      "resolution_id": @resolution.id
    }

    blog = "http://jumpstartlab.com/blog"

    PayloadRequest.create(payload2)

    assert_equal 20,
    PayloadRequest.url_avg_response_time(blog)
  end
end
