require_relative "../test_helper"

class EventTest < Minitest::Test
  include TestHelpers
  include PayloadTestData

  def setup
    gather_data
  end

  def test_event_name
    assert_equal "socialLogin", Event.find(@event.id).name
  end

  def test_ordered_by_requested
    expected = {"socialLogin"=>4, "newsBreaks"=>3, "tweet"=>2}
    assert_equal expected, Event.ordered_by_requested
  end
end
