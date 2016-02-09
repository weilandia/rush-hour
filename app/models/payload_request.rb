class PayloadRequest < ActiveRecord::Base
  belongs_to :user_agent
  belongs_to :event
  belongs_to :request_type
  belongs_to :resolution

  validates :url, presence: true
  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :request_type_id, presence: true
  validates :parameters, presence: true
  validates :event_id, presence: true
  validates :resolution_id, presence: true
  validates :ip, presence: true
  validates :user_agent_id, presence: true

  def self.avg_response_time
    average("respondedIn")
  end

  def self.max_response_time
    maximum("respondedIn")
  end

  def self.min_response_time
    minimum("respondedIn")
  end

  def self.urls_ordered_by_requested
    group("url").count.map {|k, v| k}
  end

#url specific
  def self.url_max_response_time(url)
    where(url: url).maximum("respondedIn")
  end

  def self.url_min_response_time(url)
    where(url: url).minimum("respondedIn")
  end

#Ask client what response is needed
  def self.url_response_times_ordered(url)
    where(url: url).sort_by(&:respondedIn).reverse
  end

  def self.url_avg_response_time(url)
    where(url: url).average("respondedIn")
  end

  def self.url_associated_verbs(url)
    where(url: url).map do |p|
      RequestType.find_by(id: p.id).request_type
    end.uniq
  end
end



# Average Response time for our clients app across all requests
# Max Response time across all requests
# Min Response time across all requests
# Most frequent request type
# List of all HTTP verbs used
# List of URLs listed form most requested to least requested
# Web browser breakdown across all requests(userAgent)
# OS breakdown across all requests(userAgent)
# Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
