class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "新規登録ありがとうございます。"
    else
      flash.now[:alert] = "新規登録に失敗しました。"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
