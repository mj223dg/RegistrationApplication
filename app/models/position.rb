class Position < ActiveRecord::Base
  has_one :event

  #validates :longitude, presence: true
  #validates :latitude, presence: true
  validates :address, presence: true

end