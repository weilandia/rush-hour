require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  include TestHelpers

  def setup
    @resolution = Resolution.create({resolution_width: "1920", resolution_height: "1280"})
  end

  def test_resolution_id
    assert_equal @resolution.id, Resolution.find(@resolution.id).id
  end

  def test_resolution_width
    assert_equal @resolution.resolution_width, Resolution.find(@resolution.id).resolution_width
  end

  def test_resolution_height
    assert_equal "1280", @resolution.resolution_height
  end

  def test_user_agent_browser_breakdown
    Resolution.create({resolution_width: "900", resolution_height: "700"})

    Resolution.create({resolution_width: "200", resolution_height: "300"})

    hash = {["900", "700"]=>1, ["1920", "1280"]=>1, ["200", "300"]=>1}

    assert_equal hash, Resolution.resolution_breakdown
  end

end
