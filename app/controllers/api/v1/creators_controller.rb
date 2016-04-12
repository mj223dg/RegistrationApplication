class Api::V1::CreatorsController < Api::V1::ApiController
  respond_to :json
  def index
    respond_with Creator.limit(@limit).offset(@offset)
  end

  def show
    respond_with Creator.find(params[:id])
  end

end