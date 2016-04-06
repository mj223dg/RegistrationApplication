class Api::V1::CreatorsController < ApiController

  def index
    respond_with Creator.limit(@limit).offset(@offset)
  end

  def show
    respond_with Creator.find(params[:id])
  end

end