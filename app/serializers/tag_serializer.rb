class TagSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_and_belongs_to_many :events

  def links
    {
        self: api_tag_path(object.id),
        events: api_tag_events_path(object.id)
    }
  end
end
