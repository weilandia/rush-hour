class PayloadRequest < ActiveRecord::Base
  belongs_to :agent
  belongs_to :event
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :url
  belongs_to :referral
  belongs_to :client

  validates_presence_of :url_id, :referral_id, :requested_at, :responded_in, :request_type_id, :resolution_id, :ip, :agent_id, :client_id, :digest


  def self.avg_response_time
    average(:responded_in).round(2)
  end

  def self.max_response_time
    maximum(:responded_in).round(2)
  end

  def self.min_response_time
    minimum(:responded_in).round(2)
  end
end
