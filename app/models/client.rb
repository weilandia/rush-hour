class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :events, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :agents, through: :payload_requests
  has_many :referrals, through: :payload_requests

  validates_presence_of :identifier, :root_url

  # def platform_breakdown
  #   agents.platform_breakdown
  # end

  def no_payloads?
    payload_requests.all.empty?
  end

end
