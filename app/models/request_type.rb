class RequestType < ActiveRecord::Base
  
  has_many :payload_requests

  def self.top_request_type
    group("request_type").count.max_by {|k, v| v}[0]
  end

end
