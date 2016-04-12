class Api::V1::CreatorsController < Api::V1::ApiController
  respond_to :json

  #COULDNT_FIND_ID = "couldnt find an creator with the id of "

  def index
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