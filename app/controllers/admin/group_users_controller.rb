class Admin::GroupUsersController < ApplicationController
  before_action :authenticate_admin!

  def create
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group.users << user
    redirect_to request.referer, notice: 'User added to the group.'
  end

  def destroy
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group.users.delete(user)
    redirect_to request.referer, notice: 'User removed from the group.'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user.admin?
  end
end