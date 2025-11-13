class Admin::GroupUsersController < ApplicationController
  before_action :authenticate_admin!

  def create
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group.users << user
    redirect_to request.referer, notice: 'ユーザーがグループに追加されました。'
  end

  def destroy
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group.users.delete(user)
    redirect_to request.referer, notice: 'ユーザーがグループから削除されました'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'このページにアクセスする権限がありません。' unless current_user.admin?
  end
end