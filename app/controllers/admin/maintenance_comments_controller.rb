class Admin::MaintenanceCommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @maintenance_comments = MaintenanceComment.with_deleted
  end

  def destroy
  comment = MaintenanceComment.unscoped.find_by(id: params[:id])

  if comment
    comment.soft_delete
    flash[:success] = "コメントは削除されました。"
  else
    flash[:error] = "コメントが見つかりませんでした。" 
  end

  redirect_to admin_maintenance_comments_path
  end


  def deleted_index
    @comments = MaintenanceComment.with_deleted.where.not(deleted_at: nil)
  end

  def restore
    @comment = MaintenanceComment.with_deleted.find(params[:id])
    @comment.restore
    redirect_to admin_maintenance_comments_path, notice: "コメントを復元しました。"
  end

  private
  def maintenance_comment_params
    params.require(:maintenance_comment).permit(:comment)
  end
end
