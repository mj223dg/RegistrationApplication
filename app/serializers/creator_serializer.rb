class CreatorSerializer < ActiveModel::Serializer
  attributes :id, :email, :links

  has_many :events

  def links
    {
    self: api_creator_path(object.id),
    events: api_creator_events_path(object.id)
    }
  end
end
