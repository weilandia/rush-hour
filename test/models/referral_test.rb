require_relative "../test_helper"

class ReferralTest < Minitest::Test
  include TestHelpers

  def setup
    @referral = Referral.create({referral_path: "http://jumpstartlab.com"})
  end

  def test_event_name
    assert_equal "http://jumpstartlab.com", Referral.find(@referral.id).referral_path
  end
end
