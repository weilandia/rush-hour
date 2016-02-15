require_relative '../test_helper'

class UserViewsStatisticsTest < FeatureTest
  include Rack::Test::Methods

  def test_check_client_statistics
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":13,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    visit '/sources/jumpstartlab'

    within 'h1' do
      assert page.has_content?("Jumpstartlab")
    end

    within '.user' do
      assert page.has_content?("Average response time")
      assert page.has_content?("20")
      assert page.has_content?("Resolutions")
      assert page.has_content?("1920 x 1280")
      assert page.has_content?("URL Stats")
      assert page.has_content?("http://jumpstartlab.com/blog")
      assert page.has_content?("Browser Breakdown")
      assert page.has_content?("Chrome")
      assert page.has_content?("Request Types")
      assert page.has_content?("POST")
    end
  end

  def test_incorrect_client_path_redirects_to_sign_up_page
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    visit '/sources/hello'

    within 'h1' do
      assert page.has_content?("Join Us")
    end
  end

end
