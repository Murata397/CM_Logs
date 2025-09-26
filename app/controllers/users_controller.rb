class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Thank you for logging in."
    else
      flash.now[:alert] = "Login failed."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
