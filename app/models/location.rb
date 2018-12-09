class Location < ApplicationRecord
  belongs_to :user
  has_many :shared_locations
  geocoded_by :address
  after_validation :geocode
end
