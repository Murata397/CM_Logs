class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:destroy, :restore]

  def destroy
    if @user.guest_user?
      redirect_to admin_dashboards_path, alert: 'ゲストユーザーは削除できません。'
    else
      @user.soft_delete
      redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
  end

  def restore
    @user.update(deleted_at: nil)
    redirect_to admin_dashboards_path, notice: 'ユーザーを復元しました。'
  end

  private

  def set_user
    @user = User.with_deleted.find(params[:id])
  end
end