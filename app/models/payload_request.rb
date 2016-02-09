class PayloadRequest < ActiveRecord::Base
  belongs_to :browser
  belongs_to :event
  belongs_to :platform
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
end
