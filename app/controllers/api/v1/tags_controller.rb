class Api::V1::TagsController < Api::V1::ApiController
  respond_to :json
  before_action :offset_params, only: [:index]

  #COULDNT_FIND_ID = "couldnt find an event with the id of "
  COULDT_FIND_EVENT = "couldnt find event id"
  NEED_A_EVENT = "Need a event"
  COULDNT_PARSE_JSON = "Couldnt parse json"

  def index
    if params[:event_id]
      event = Event.find_by_id(params[:event_id])
      if event.present?
        tags = event.tags
      else
        render json: {error: "couldnt find an tags with the id of #{params[:id]}" }, status: :not_found and return
      end
    else
      tags = Tag.all
    end
    respond_with tags, status: :ok
  end

  def create
    if params[:event_id].blank?
      render json: {error: COULDT_FIND_EVENT} and return
    end

    event = Event.find_by_id(params[:event_id])
    render json: {error: NEED_A_EVENT} and return unless event.present?
    event = Event.find_by_id(params[:event_id])

    begin
      if Tag.find_by(name: tag_params[:name])
        tag = Tag.find_by(name: tag_params[:name])
      else
        tag = Tag.new(tag_params)
      end
      if tag.save
        event.tags << tag
        render json: tag, status: 201, location: [:api, tag]
      else
        render json: {errors: tag.errors}, status: 402
      end
    rescue JSON::ParserError => e
      render json: {error:COULDNT_PARSE_JSON }, status: :bad_request
    end
  end

  def show
    tag = Tag.find_by_id(params[:id])
    if tag.present?
      respond_with tag, status: :ok
    else
      render json: {error: "couldnt find a tag with the id of #{params[:id]}" }, status: :not_found and return
    end
  end

  private
  def tag_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:tag).permit(:name)
  end

end
