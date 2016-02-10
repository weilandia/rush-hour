require_relative "../test_helper"

class UserAgentTest < Minitest::Test
  include TestHelpers
  include PayloadTestData

  def setup
    gather_data
  end


  def test_user_agent_platform
    assert_equal "Macintosh", @user_agent.platform
  end

  def test_user_agent_browser
    assert_equal "Chrome", @user_agent.browser
  end

  def test_user_agent_browser_breakdown
    UserAgent.create({browser: "Safari", platform: "Macintosh"})

    UserAgent.create({browser: "Pearl", platform: "Macintosh"})

    expected = {"Chrome"=>1, "Pearl"=>1, "Safari"=>1}

    assert_equal expected, UserAgent.browser_breakdown
  end

  def test_user_agent_platform_breakdown
    UserAgent.create({browser: "Safari", platform: "Linux"})

    UserAgent.create({browser: "Pearl", platform: "Windows"})

    expected = {"Linux"=>1, "Windows"=>1, "Macintosh"=>1}

    assert_equal expected, UserAgent.platform_breakdown
  end
end
