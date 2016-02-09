class UserAgent < ActiveRecord::Base
  has_many :payload_requests

  def self.browser_breakdown
    group("browser").count
  end

  def self.platform_breakdown
    group("platform").count
  end

end
