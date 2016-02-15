require_relative '../test_helper'

class UserViewsUrlStatisticsTest < FeatureTest
  include Rack::Test::Methods

  def test_check_url_statistics
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":13,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    post 'http://localhost:9393/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com/fun","requestType":"POST","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'


    visit '/sources/jumpstartlab/urls/blog'

    within 'h1' do
      assert page.has_content?("jumpstartlab.com/blog")
    end

    assert page.has_content?("Average response time")
    assert page.has_content?("17.5")
    assert page.has_content?("Max response time")
    assert page.has_content?("37")
    assert page.has_content?("Min response time")
    assert page.has_content?("10")
    assert page.has_content?("Response Times Ordered by Frequency")
    assert page.has_content?("Associated Verbs")
    assert page.has_content?("POST")
    assert page.has_content?("Top Referrals")
    assert page.has_content?("http://jumpstartlab.com/fun")
    assert page.has_content?("Top User Agents")
    assert page.has_content?("Chrome")
  end

  def test_no_payload_data_error_for_urls
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}


    visit '/sources/jumpstartlab/urls/hello'

    within 'h1' do
      assert page.has_content?("jumpstartlab")
    end
    assert page.has_content?("No payload data has been received for hello")
  end

end
