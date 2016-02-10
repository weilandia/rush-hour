class Event < ActiveRecord::Base
  has_many :payload_requests

  def self.ordered_by_requested
    joins(:payload_requests).group("events.name").order(count: :desc, name: :asc).count
  end
end
