class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have update user successfully"
      redirect_to user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
    @user.destroy
    sign_out @user
    redirect_to root_path, notice: "Your cancellation is complete. You have been logged out."
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :profile_image, :introduction)
  end
end
