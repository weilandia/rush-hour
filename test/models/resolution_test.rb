require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  include TestHelpers
  include PayloadTestData

  def setup
    gather_data
  end

  def test_resolution_width
    assert_equal "1920", @resolution.width
  end

  def test_resolution_height
    assert_equal "1280", @resolution.height
  end

  def test_user_agent_browser_breakdown
    Resolution.create({width: "200", height: "300"})

    expected = {["400", "500"]=>1, ["1920", "1280"]=>1, ["200", "300"]=>1}

    assert_equal expected, Resolution.breakdown
  end

end
