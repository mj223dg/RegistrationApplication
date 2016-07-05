class HomeController < ApplicationController
  def index
    @user = currentdev_user
  end
end
