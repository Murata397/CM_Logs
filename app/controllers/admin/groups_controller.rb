class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group, only: [:edit, :update, :destroy]
  layout 'admin'

  def index
    @groups = Group.unscoped.all
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to admin_groups_path, notice: 'グループ情報が更新されました。'
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.soft_delete
    redirect_to admin_groups_path, notice: 'グループを削除しました。'
  end

  def deleted_index
    @groups = Group.unscoped.where.not(deleted_at: nil)
  end

  def restore
    @group = Group.unscoped.find(params[:id])
    if @group.restore
      redirect_to admin_groups_path, notice: "グループを復元しました"
    else
      redirect_to admin_groups_path, alert: "復元に失敗: #{@group.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_group
    @group = Group.unscoped.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :group_introduction, :group_image, :group_theme, :group_rules)
  end
end