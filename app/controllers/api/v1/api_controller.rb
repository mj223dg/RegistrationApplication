class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  include Knock::Authenticable
  protect_from_forgery with: :null_session
  before_action :authenticate

  THERE_IS_NO_API_KEY = "Api-key is missing"

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
    app = App.where(api_key: api_key).first if api_key
    unless app
      render json: {error: THERE_IS_NO_API_KEY}, status: :not_found
    end

  end
end
