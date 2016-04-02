class Position < ActiveRecord::Base
  has_one :events

  validates :longitude, presence: true
  validates :latitude, presence: true


end
