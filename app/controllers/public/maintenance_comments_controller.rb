class Public::MaintenanceCommentsController < ApplicationController
  def create
    maintenance = Maintenance.find(params[:maintenance_id])
    comment = current_user.maintenance_comments.new(maintenance_comment_params)
    comment.maintenance_id = maintenance.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    MaintenanceComment.find_by(id: params[:id], maintenance_id: params[:maintenance_id]).destroy
    redirect_to request.referer
  end

  private
  def maintenance_comment_params
    params.require(:maintenance_comment).permit(:comment)
  end
end
