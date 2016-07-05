class PositionSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :address, :links


  def links
    {
        self: api_position_path(object.id),
        event: api_position_event_path(object.id)
    }
  end
end
