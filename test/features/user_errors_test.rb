require_relative '../test_helper'

class UserErrorsTest < FeatureTest
  include Rack::Test::Methods

  def test_registers_twice
    visit '/sources/signup'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Join')

    visit '/sources/signup'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Join')

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

    visit '/sources/hello'

    within 'h1' do
      assert page.has_content?("Join Us")
    end
  end

  def test_no_payload_data_error_for_events
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    visit '/sources/jumpstartlab/events/hello'

    within 'h1' do
      assert page.has_content?("jumpstartlab")
    end
    assert page.has_content?("No event data has been received for hello")
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
