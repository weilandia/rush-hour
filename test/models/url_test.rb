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
    expected = {10=>1, 130=>7, 190=>1}
    assert_equal expected, @url_1.response_times_ordered
  end

  def test_avg_response_time
    assert_equal 123.33, @url_1.avg_response_time.round(2)
  end

  def test_associated_verbs
    expected = {"GET"=>9}
    assert_equal expected, @url_1.associated_verbs
  end

  def test_top_three_referrers
    assert_equal [["http://jumpstartlab.com/4", 3], ["http://jumpstartlab.com/3", 2], ["http://jumpstartlab.com/2", 2]], @url_1.top_three_referrers
  end

end

# Three most popular referrers
# Three most popular user agents
