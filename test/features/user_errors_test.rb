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

  def test_random_path
    visit '/this_is_an_error'

    within 'h1' do
      assert page.has_content?("Error Page")
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

end
