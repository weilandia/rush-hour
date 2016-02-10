require_relative '../test_helper'
require 'json'

class CreateServerTest < Minitest::Test
  include Rack::Test::Methods #will get post, get, etc.
  include TestHelpers

  def test_valid_attributes
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "", last_response.body #last response is a rack thing
  end

  def test_no_identifier
    post '/sources', {rootUrl: "http://jumpstartlab.com"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body #last response is a rack thing
  end

  def test_no_root_url
    post '/sources', {identifier: "jumpstartlab"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body #last response is a rack thing
  end

  def test_client_already_exists
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Client jumpstartlab already exists.", last_response.body #last response is a rack thing
  end

end
