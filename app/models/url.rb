class Url < ActiveRecord::Base
  has_many :payload_requests

  # def get_url_string(id)
  #   find(id).path
  # end

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
    # require 'pry'
    # binding.pry
    # map do |p|
    #   RequestType.find_by(id: p.id).request_type
    # end.uniq
  end
end
