class Resolution < ActiveRecord::Base
  has_many :payload_requests

  def self.breakdown
    group([:width, :height]).count
  end
end
