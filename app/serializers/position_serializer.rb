class PositionSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :address

  has_one :event
end
