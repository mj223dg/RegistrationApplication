class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  include Knock::Authenticable
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_filter :restrict_access

  THERE_IS_NO_API_KEY = "Wrong api-key"

  #default parameters
  OFFSET = 0
  LIMIT = 20

  # check if user wants offset/limit
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit ||= LIMIT
  end

  private
  def restrict_access
    api_key = request.headers["apikey"]
    app = App.where(apikey: api_key).first if api_key
    render json: {error: THERE_IS_NO_API_KEY}, status: :not_found unless app

  end
end
