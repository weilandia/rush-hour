class Url < ActiveRecord::Base
  has_many :payload_requests

  def max_response_time
    # payload_requests.maximum("responded_in")
  end

  #url specific
    def self.url_max_response_time(url)
      where(url: url).maximum("responded_in")
    end

    def self.url_min_response_time(url)
      where(url: url).minimum("responded_in")
    end

  #Ask client what response is needed
    def self.url_response_times_ordered(url)
      where(url: url).sort_by(&:responded_in).reverse
    end

    def self.url_avg_response_time(url)
      where(url: url).average("responded_in")
    end

    def self.url_associated_verbs(url)
      where(url: url).map do |p|
        RequestType.find_by(id: p.id).request_type
      end.uniq
    end
end
