class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :archive]

  def index
    @users = User.excluding_archived.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render "new"
    end
  end

  def edit
  end

  def show
  end

  def update
    # if you submit a blank password, it should mean “don’t change the user’s
    # current password.” So you can remove the field if it’s blank, before you
    # update the user.
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been updated."
      render "edit"
    end
  end

  def archive
    if @user == current_user
      flash[:alert] = "You cannot archive yourself!"
    else
      @user.archive
      flash[:notice] = "User has been archived."
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
