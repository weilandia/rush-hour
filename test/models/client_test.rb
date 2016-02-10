require_relative "../test_helper"

class ClientTest < Minitest::Test
  include TestHelpers

  def setup
    @client = Client.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"})
  end

  def test_client_has_valid_attributes
    assert_equal            "jumpstartlab", @client.identifier
    assert_equal "http://jumpstartlab.com", @client.root_url
  end

end
