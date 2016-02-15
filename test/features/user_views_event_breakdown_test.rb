require_relative '../test_helper'

class UserViewsEventBreakdownTest < FeatureTest
  include Rack::Test::Methods

  def test_event_statistics
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":13,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":13,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"hello","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'


    visit '/sources/jumpstartlab/events/socialLogin'

    within 'h1' do
      assert page.has_content?("socialLogin")
    end

    within '.user' do
      assert page.has_content?("Hourly Breakdown")
      assert page.has_content?("Total Hits")
      assert page.has_content?("2")
    end

    visit '/sources/jumpstartlab/events/hello'

    within 'h1' do
      assert page.has_content?("hello")
    end

  end

  def test_no_payload_data_error_for_events
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    visit '/sources/jumpstartlab/events/hello'

    within 'h1' do
      assert page.has_content?("jumpstartlab")
    end
    assert page.has_content?("No event data has been received for hello
")
  end

end
