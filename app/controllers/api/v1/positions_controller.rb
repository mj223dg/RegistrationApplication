class Api::V1::PositionsController < Api::V1::ApiController
  respond_to :json
  def index
    respond_with Position.limit(@limit).offset(@offset)
  end

  def
    show
    respond_with Position.find_by_id(params[:id])
  end
end
