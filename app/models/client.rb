class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :events, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :agents, through: :payload_requests
  has_many :referrals, through: :payload_requests

  validates_presence_of :identifier, :root_url

  def platform_breakdown
    agents.platform_breakdown
  end

  def resolution_breakdown
    resolutions.breakdown
  end

  def browser_breakdown
    agents.browser_breakdown
  end

  def top_request_types
    request_types.top
  end

  def all_verbs
    request_types.all_verbs
  end

  def avg_response_time
    payload_requests.avg_response_time
  end

  def max_response_time
    payload_requests.max_response_time
  end

  def min_response_time
    payload_requests.min_response_time
  end

  def no_payloads?
    payload_requests.all.empty?
  end

  def client_name
    identifier.capitalize
  end

end
