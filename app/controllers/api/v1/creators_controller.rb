class Api::V1::CreatorsController < Api::V1::ApiController
  respond_to :json
  before_action :offset_params, only: [:index]
  #COULDNT_FIND_ID = "couldnt find an creator with the id of "

  def index
    creators = Creator.limit(@limit).offset(@offset)

    respond_with Creator.limit(@limit).offset(@offset)

  end

  def show
    creator = Creator.find_by_id(params[:id])
    if creator.present?
    respond_with Creator.find_by_id(params[:id])
    else
      render json:  {error: "couldnt find an creator with the id of #{params[:id]}" }, status: :not_found
    end
  end
end
