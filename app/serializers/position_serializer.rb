class PositionSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :address


  def links
    {
        self: api_creator_path(object.id),
        event: api_position_event_path(object.id)
    }
  end
end
