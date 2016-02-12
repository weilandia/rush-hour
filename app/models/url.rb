class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrals, through: :payload_requests
  has_many :agents, through: :payload_requests

  validates_presence_of :path, :host, :relative_path
  def avg_response_time
    payload_requests.maximum(:responded_in)
  end

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def response_times_ordered
    payload_requests.group(:responded_in).order(:responded_in).count
  end

  def avg_response_time
    payload_requests.average(:responded_in).round(2)
  end

  def associated_verbs
    request_types.group(:verb).count
  end

  def self.ordered_by_requested
    group("urls.path").order(count: :desc, path: :asc).count
  end

  def top_three_referrers
    referrals.group(:referral_path).order(count: :desc, referral_path: :asc).count.take(3)
  end

  def top_three_user_agents
    agents.group([:browser, :platform]).order(count: :desc, browser: :asc).count.take(3)
  end
end
