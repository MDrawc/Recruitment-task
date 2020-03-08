class IpRecord < ApplicationRecord
  before_save { query.downcase! }
  validates :query, presence: true, uniqueness: { case_sensitive: false }
  validates :ip_type, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
