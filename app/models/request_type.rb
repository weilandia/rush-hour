class RequestType < ActiveRecord::Base
  has_many :payload_requests

  def self.top
    # return if !exists?(:verb)
    all_verbs.max_by {|_verb, count| count}.first
  end

  def self.all_verbs
    group(:verb).count
  end
end
