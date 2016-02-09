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
