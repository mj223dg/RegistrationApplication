class Api::V1::PositionsController < Api::V1::ApiController
  respond_to :json

  #COULDNT_FIND_ID = "couldnt find a position with the id of "
  def index
    respond_with Position.limit(@limit).offset(@offset)
  end

  def
    show
    position = Position.find_by_id(params[:id])
    if position.present?
    respond_with Position.find_by_id(params[:id])
    else
      render json: {error: "couldnt find an position with the id of #{params[:id]}" }, status: :not_found
    end
  end
end
