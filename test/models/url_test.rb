require_relative "../test_helper"

class UrlTest < Minitest::Test
  include PayloadTestData
  include TestHelpers

  def setup
    gather_data
  end

  def test_max_response_time
    assert_equal 190, @url_1.max_response_time
  end

  def test_min_response_time
    assert_equal 10, @url_1.min_response_time
  end

  def test_ordered_response_time
    expected = {190=>1, 10=>1}
    assert_equal expected, @url_1.response_times_ordered
  end

  def test_avg_response_time
    assert_equal 100.0, @url_1.avg_response_time
  end

  def test_associated_verbs
    expected = {"GET"=>2}
    assert_equal expected, @url_1.associated_verbs
  end
end

# Max Response time
# Min Response time
# A list of response times across all requests listed from longest response time to shortest response time.
# Average Response time for this URL
# HTTP Verb(s) associated used to it this URL
# Three most popular referrers
# Three most popular user agents
