class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_one :position
  has_one :creator
  has_many :tags

  def links
    {
        self: api_event_path(object.id),
        position: api_event_position_path(object.id),
        tag: api_event_tags_path(object.id)
    }
  end
end
