class Resolution < ActiveRecord::Base
  has_many :payload_requests

  def self.breakdown
    group([:width, :height]).count
  end

end

# class ClientPresenter
#   def initialize(client)
#     @client = client
#   end
#
#   def resolution_breakdown
#     @client.resolutions.breakdown.map { |}
#   end
# end
