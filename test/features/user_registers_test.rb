require_relative '../test_helper'

class UserRegistersTest < FeatureTest
  include Rack::Test::Methods

  def test_user_registers_page_with_interface
    visit '/'

    click_link('Join Us')

    assert_equal '/sources/signup', current_path

    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Join')

    assert_equal '/sources', current_path

    within '#thanks' do
      assert page.has_content?("Thanks for joining us jumpstartlab!")
    end
  end

  def test_index_path
    visit '/'
    within '#index' do
      assert page.has_content?("RushHour")
    end

    within "#index-header" do
      assert page.has_content?("Turning insights into actions.")
    end
  end

  def test_index_navigation
    visit '/'

    click_link('Join Us')

    assert_equal '/sources/signup', current_path

    click_link('RushHour')

    assert_equal '/', current_path

    within "#index-header" do
      assert page.has_content?("Turning insights into actions.")
    end
  end
end
