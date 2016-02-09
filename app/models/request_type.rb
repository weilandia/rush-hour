class RequestType < ActiveRecord::Base

  has_many :payload_requests

  def self.top_request_type
    group("request_type").count.max_by {|k, v| v}[0]
  end

  def self.all_request_types
    all.map(&:request_type).uniq
  end

end
