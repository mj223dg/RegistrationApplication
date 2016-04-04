class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_one :position
  has_one :creator
  has_many :tags

end
