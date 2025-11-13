class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @user = User.find(params[:id])
    
    if @user.guest_user?
      redirect_to admin_dashboards_path, alert: 'ゲストユーザーは削除できません。'
    else
      @user.destroy
      redirect_to admin_dashboards_path, notice: 'ユーザー情報の削除に成功しました。'
    end
  end
end