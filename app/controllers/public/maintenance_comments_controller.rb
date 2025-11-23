class Public::MaintenanceCommentsController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :check_guest_user, except: []


  def create
    maintenance = Maintenance.find(params[:maintenance_id])
    comment = current_user.maintenance_comments.new(maintenance_comment_params)
    comment.maintenance_id = maintenance.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    MaintenanceComment.find_by(id: params[:id], maintenance_id: params[:maintenance_id]).soft_delete
    redirect_to request.referer
  end

  def check_guest_user
    if current_user && current_user.guest_user?
      redirect_to @current_user, notice: "ゲストユーザーはこの操作を実行できません。  ログアウト後、新規登録してください。"
    end
  end

  private
  def maintenance_comment_params
    params.require(:maintenance_comment).permit(:comment)
  end
end
