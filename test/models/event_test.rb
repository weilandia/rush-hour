require_relative "../test_helper"

class EventTest < Minitest::Test
  include TestHelpers

  def setup
    @event = Event.create({name: "socialLogin"})
  end

  def test_event_name
    assert_equal "socialLogin", Event.find(@event.id).name
  end

end
