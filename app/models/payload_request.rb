class PayloadRequest < ActiveRecord::Base
  belongs_to :user_agent
  belongs_to :event
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :url
  belongs_to :referral

  validates :url_id, presence: true
  validates :referral_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :request_type_id, presence: true
  validates :resolution_id, presence: true
  validates :ip, presence: true
  validates :user_agent_id, presence: true

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
    urls = group(:url_id).count.map { |k, v| [Url.find_by(id: k).path, v] }
    urls.sort_by { |k, v| v }.reverse.to_h
     #take out ruby methods later
  end

  def self.events
    e = group(:event_id).count.map do |k, v|
      if Event.find_by(id: k).nil? then ["no event", v]
      else [Event.find_by(id: k).name, v]
      end
    end
    e.sort_by { |k, v| v }.reverse.to_h
  end
end
