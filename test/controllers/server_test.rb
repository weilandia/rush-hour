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

  def test_payload_request_posts
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
  end

  def test_invalid_payload_request_errors
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280"}'

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "Ip can't be blank", last_response.body
  end

  def test_payload_request_error_client_does_not_exist
    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 0, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Client jumpstartlab does not exist.", last_response.body
  end

end
