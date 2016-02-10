class Client < ActiveRecord::Base
  has_many :payload_requests

  validates_presence_of :identifier, :root_url
end
