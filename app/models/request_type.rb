class RequestType < ActiveRecord::Base

  has_many :payload_requests

  def self.top
    group(:verb).count.max_by {|k, v| v}[0]
  end

  def self.all_verbs
    group(:verb).count
  end

end
