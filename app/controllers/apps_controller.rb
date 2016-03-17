class AppsController < ApplicationController

  APPLICATION_CREATED = "Application created"
  APPLICATION_DELETED = "Application deleted"
  def new
    @app = App.new
  end

  def create
    @app = currentdev_user.apps.build(app_params)
    if @app.save
      flash[:success] = APPLICATION_CREATED
      redirect_to currentdev_user
    else
      render 'new'
    end
  end

  def destroy
    App.find(params[:id]).destroy
    flash[:success] = APPLICATION_DELETED
    redirect_to currentdev_user
  end

  private
  def app_params
    params.require(:app).permit(:name, :apikey)
  end
end
