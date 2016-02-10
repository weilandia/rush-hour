class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrals, through: :payload_requests
  has_many :user_agents, through: :payload_requests

  #url specific
  def max_response_time
    payload_requests.maximum("responded_in")
  end

  def min_response_time
    payload_requests.minimum("responded_in")
  end

  def response_times_ordered
    payload_requests.group("responded_in").order("responded_in").count
    # payload_requests.sort_by(&:responded_in).reverse
  end

  def avg_response_time
    payload_requests.average("responded_in")
  end

  def associated_verbs
    request_types.group("verb").count
  end

  def top_three_referrers
    referrals.group("referred_by_id")
  end

  def top_three_user_agents

  end

end
