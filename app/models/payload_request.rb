class PayloadRequest < ActiveRecord::Base
  belongs_to :user_agent
  belongs_to :event
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :url
  belongs_to :referral
  belongs_to :client

  validates_presence_of :url_id, :referral_id, :requested_at, :responded_in, :request_type_id, :resolution_id, :ip,:user_agent_id

  def self.avg_response_time
    average(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end

  def self.urls_ordered_by_requested
    urls = group(:url_id).count.map { |k, v| [Url.find(k), v] }
    urls.sort_by { |k, v| v }.reverse.to_h
    # urls = self.all.map { |p| p.url }.uniq
    # urls.map { |u| [u.path, u.payload_requests.count] }
  end

  def self.events
    e = group(:event_id).count.map do |k, v|
      if Event.find_by(id: k).nil? then ["no event", v]
      else [Event.find(k).name, v]
      end
    end
    e.sort_by { |k, v| v }.reverse.to_h
  end
end
