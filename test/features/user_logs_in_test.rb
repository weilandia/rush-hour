require_relative '../test_helper'

class UserLogsInTest < FeatureTest
  include Rack::Test::Methods

  def test_user_logs_in
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    visit '/'

    click_link('login')

    assert_equal '/login', current_path

    fill_in('name', with: 'jumpstartlab')
    fill_in('password', with: 'asdaskjh231')
    click_button('Login')

    assert_equal '/sources/jumpstartlab', current_path

    within 'h1' do
      assert page.has_content?("Jumpstartlab")
    end

    assert page.has_content?("No payload data has been received for Jumpstartlab")
  end
end
