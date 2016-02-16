require_relative "../test_helper"

class AgentTest < Minitest::Test
  include TestHelpers
  include PayloadTestData

  def setup
    gather_data
  end

  def test_agent_platform
    assert_equal "Macintosh", @agent.platform
  end

  def test_agent_browser
    assert_equal "Chrome", @agent.browser
  end

  def test_agent_browser_breakdown
    Agent.create({browser: "Safari", platform: "Macintosh"})

    Agent.create({browser: "Pearl", platform: "Macintosh"})

    expected = {"Chrome"=>2, "Pearl"=>1, "Mozilla"=>1, "Safari"=>2}

    assert_equal expected, Agent.browser_breakdown
  end

  def test_agent_platform_breakdown
    Agent.create({browser: "Safari", platform: "Linux"})

    Agent.create({browser: "Pearl", platform: "Windows"})

    expected = {"Linux"=>1, "Macintosh"=>2, "Windows"=>3}

    assert_equal expected, Agent.platform_breakdown
  end
end
