require_relative '../test_helper'

class UserErrorsTest < FeatureTest
  include Rack::Test::Methods

  def test_registers_twice
    visit '/sources/signup'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Login')

    visit '/sources/signup'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Login')

    assert_equal '/sources', current_path
    assert page.has_content?("Client jumpstartlab already exists.")
  end

  def test_incorrect_path
    visit '/this_is_an_error'

    within 'h1' do
      assert page.has_content?("Error Page")
    end
  end

  def test_redirect_user_to_signup_with_they_log_in_without_signing_up
    visit '/'

    click_link('login')

    assert_equal '/login', current_path

    fill_in('name', with: 'jumpstartlab')
    fill_in('password', with: 'asdaskjh231')
    click_button('Login')

    within 'h1' do
      assert page.has_content?("Join Us")
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
