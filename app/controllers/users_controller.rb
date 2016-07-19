class UsersController < ApplicationController

  # before_action :check_if_correct_user, only: [:show, :edit, :update]

  WELCOME_TEXT = "Välkommen"

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if @user.admin?
      @apps = App.all
    else
      @apps = @user.apps
    end
  end

  def create
    @user = User.new(user_params)
    redirect_to root_path unless @user == currentdev_user
    if @user.save
      log_in @user
      flash[:success] = WELCOME_TEXT
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
