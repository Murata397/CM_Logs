class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group, only: [:edit, :update, :destroy]
  layout 'admin'

  def index
    @groups = Group.all
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
    ActiveRecord::Base.transaction do
      @group.group_users.destroy_all
      @group.destroy
    end
    redirect_to admin_groups_path, notice: 'グループ情報および関連情報が削除されました。'
  end


  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :group_introduction, :group_image, :group_theme, :group_rules)
  end

end