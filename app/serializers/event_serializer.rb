class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :links

  has_one :position
  has_one :creator
  has_many :tags

  def links
    {
        self: api_event_path(object.id),
        position: api_position_path(object.position.id),
        tag: api_event_tags_path(object.id)
    }
  end
end
