require_relative '../test_helper'

class UserErrorsTest < FeatureTest
  include Rack::Test::Methods

  def test_registers_twice
    visit '/sources/signup/jumpstartlab'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Join')

    visit '/sources/signup/jumpstartlab'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Join')

    assert_equal '/sources', current_path
    assert page.has_content?("Client jumpstartlab already exists.") #how is this working
  end

end
