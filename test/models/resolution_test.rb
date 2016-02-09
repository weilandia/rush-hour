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
    assert_equal @resolution.resolution_height, Resolution.find(@resolution.id).resolution_height
  end

end
