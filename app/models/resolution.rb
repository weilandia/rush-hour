class Resolution < ActiveRecord::Base
  has_many :payload_requests

  def self.resolution_breakdown
    group(["resolution_width", "resolution_height"]).count
  end

end
