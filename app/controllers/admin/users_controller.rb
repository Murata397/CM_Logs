class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_user, only: [:destroy, :restore]

  def index
    @users = User.where(deleted_at: nil)
  end

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

  def deleted_index
    @users = User.unscoped.where.not(deleted_at: nil)
  end

  private

  def set_user
    @user = User.unscoped.find(params[:id])
  end
end