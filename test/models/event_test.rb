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
    assert_equal expected, Client.all[1].events.ordered_by_requested
  end

  def test_total
    assert_equal 3, Client.all[1].events.find(2).total
  end

  def test_by_hour
    assert_equal 2, Client.all[1].events.find(2).by_hour(4)
  end
end
