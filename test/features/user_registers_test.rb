require_relative '../test_helper'

class UserRegistersTest < FeatureTest
  include Rack::Test::Methods

  def test_user_registers_page_with_interface
    visit '/sources/signup/jumpstartlab'
    fill_in('identifier', with: 'jumpstartlab')
    fill_in('rootUrl', with: 'http://jumpstartlab.com')
    click_button('Join')

    visit '/sources/jumpstartlab'
    assert page.has_content?("Jumpstartlab")
  end

end
