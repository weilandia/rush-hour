class Event < ActiveRecord::Base
  has_many :payload_requests

  def self.ordered_by_requested
    group("events.name").order(count: :desc, name: :asc).count
  end

  def total
    payload_requests.count
  end

  def by_hour(hour)
    payload_requests.pluck(:requested_at).map do |time|
      time.hour
    end.count(hour)
  end
end
