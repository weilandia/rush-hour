require_relative "../test_helper"

class EventTest < Minitest::Test
  include TestHelpers

  def setup
    @event = Event.create({event: "socialLogin"})
  end

  def test_event_id
    assert_equal @event.id, Event.find(@event.id).id
  end

  def test_event_name
    assert_equal @event.event, Event.find(@event.id).event
  end

end
