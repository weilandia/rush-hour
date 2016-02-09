require_relative "../test_helper"

class UserAgentTest < Minitest::Test
  include TestHelpers
  
  def setup
    @user_agent = UserAgent.create({browser: "Chrome", platform: "Macintosh"})
  end

  def test_user_agent_id
    assert_equal @user_agent.id, UserAgent.find(@user_agent.id).id
  end

  def test_user_agent_platform
    assert_equal @user_agent.platform, UserAgent.find(@user_agent.id).platform
  end

  def test_user_agent_browser
    assert_equal @user_agent.browser, UserAgent.find(@user_agent.id).browser
  end

end
