require_relative '../test_helper'

class UserRegistersTest < FeatureTest
  include Rack::Test::Methods


  def test_index_path
    visit '/'
    within '#index' do
      assert page.has_content?("RushHour")
    end

    within "#index-header" do
      assert page.has_content?("Turning insights into actions.")
    end
  end

  def test_user_registers_page_with_interface
    visit '/'

    click_link('Join Us')

    assert_equal '/sources/signup', current_path

    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Login')

    visit '/sources/jumpstartlab' #redirect to sources right now

    within 'h1' do
      assert page.has_content?("Jumpstartlab")
    end

    assert page.has_content?("No payload data has been received for Jumpstartlab")
  end

end
