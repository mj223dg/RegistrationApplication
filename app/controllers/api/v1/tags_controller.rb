class Api::V1::TagsController < ApplicationController
  respond_to :json

  def index
    if (params[:event_id])
      event = Event.find_by_id(params[:event_id])
      if event.present?
        tags = event.tags
      else
        render json: {}
      end
    end
  end
end
