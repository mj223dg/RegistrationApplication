class Api::V1::EventsController < Api::V1::ApiController
  respond_to :json
  before_action :authenticate
  #COULDNT_FIND_ID = "couldnt find an event with the id of "
  CANNOT_FIND_EVENT = "Couldnt find any event"
  COULDNT_PARSE_JSON = "Couldnt parse json"
  UPD = "update"
  CANNOT_EDIT = "Couldnt edit"
  CANNOT_DESTROY = "Couldnt destroy"
  DESTROY = "destroy"
  #EVENT_WITH_ID = "The event with id "
  #REMOVED = " was removed"
  EVENT_POSITION = "The event need a position"
  DISTANCE = 10
  OCCUPIED_LOCATION = "There is already an event on this location."

  def index
    if params[:tag_id]
      tag = Tag.find_by_id(params[:tag_id])
      events = tag.events.limit(@limit).offset(@offset) if tag.present?
    elsif params[:creator_id]
      creator = Creator.find_by_id(params{:creator_id})
      events =creator.events.limit(@limit).offset(@offset) if creator.present?
    elsif params[:nearby_addresses]
      events = get_nearby_positions(params[:nearby_addresses])
    else
      events = Event.all
    end
    if events.present?
      events = events.starts_with(params[:starts_with]) if params[:starts_with]
      response = {offset: @offset, limit: @limit, count: events.count, events: ActiveModel::ArraySerializer.new(events)}
      respond_with response
    else
      render json: {error: CANNOT_FIND_EVENT }, status: :not_found
    end
  end

  def show
    event = Event.find_by_id(params[:id])
    if event.present?
      respond_with event, status: :ok
    else
      render json: {error: "couldnt find an event with the id of #{params[:id]}" }, status: :not_found
    end
  end

  def create
    begin
      return unless position_param_present? && position_is_available?
      event = Event.new(event_params.except(:tags, :position))
      event.creator = current_user
      10.times {puts current_user.id}
      tags = event_params[:tags]

      if tags
        tags.each do |t|

          event.tags << Tag.where(t).first_or_create
        end
      end

      if event.save

        event.position = Position.create(event_params[:position])
        event.position.save
        10.times { puts event.position }
        respond_with event, status: 201, location: [:api, event]
      else
        render json: {errors: event.errors.messages}, status: :bad_request
      end
    rescue JSON::ParserError => e
      render json: {error: COULDNT_PARSE_JSON}, status: :bad_request
    end
  end

  def update
    event = Event.find_by_id(params[:id])
    render json: {error: CANNOT_FIND_EVENT}, stauts: :bad_request and return unless event
    render json: {error: CANNOT_EDIT}, status: :unauthorized and return unless current_user == event.creator

    begin
      if event.update(event_params)
        render json: {action: UPD, event: EventSerializer.new(event)}, status: :ok
      else
        render json: {error: event.errors.messages}, status: :bad_request
      end
    rescue JSON::ParserError => e
      render json: {error: COULDNT_PARSE_JSON}, status: :bad_request
    end
  end

  def destroy
    event = Event.find_by_id(params[:id])

    render json: {error: CANNOT_FIND_EVENT}, stauts: :bad_request and return unless event
    render json: {error: CANNOT_DESTROY}, status: :bad_request and return unless current_user == event.creator
    event.destroy
    render json: {action: DESTROY, message: "The event with id #{params[:id]} was removed"}, status: :ok
  end

  private

  def event_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:event).permit(:name, :description, tags: [:name], position: [:address])
  end

  def position_param_present?
    if event_params[:position].blank?
      render json: {errors: EVENT_POSITION}
      return false
    end
    true
  end

  def position_is_available?
    if Position.find_by_address(event_params[:position][:address])
      render json: { errors: OCCUPIED_LOCATION}, status: :conflict
      return false
    end
    true
  end

  def get_nearby_positions(positions_params)
    events = []
    distance = params[:distance] ? params[:distance] : DISTANCE
    positions = Position.near(positions_params, distance, :units => :km)
    positions.each do |d|
      events << d.event
    end
    events
  end
end
