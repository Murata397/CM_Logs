class Admin::MaintenanceCommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @maintenance_comments = MaintenanceComment.all
  end

  def destroy
    maintenance = Maintenance.find_by(id: params[:maintenance_id])
  
    if maintenance
      comment = maintenance.maintenance_comments.find_by(id: params[:id])
  
      if comment
        comment.destroy
        flash[:success] = "コメントは削除されました。"
      else
        flash[:error] = "コメントが見つかりませんでした。"
      end
    else
      flash[:error] = "メンテナンス情報が見つかりません"
    end
  
    redirect_to admin_maintenance_comments_path
  end

  private
  def maintenance_comment_params
    params.require(:maintenance_comment).permit(:comment)
  end
end
