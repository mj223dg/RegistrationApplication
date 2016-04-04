class Position < ActiveRecord::Base
  has_one :event

  #validates :longitude, presence: true
  #validates :latitude, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode,
                   :if => :address_changed?

end