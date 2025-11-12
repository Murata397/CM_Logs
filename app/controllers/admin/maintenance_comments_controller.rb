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
        flash[:success] = "Comment deleted."
      else
        flash[:error] = "No comments found."
      end
    else
      flash[:error] = "Maintenance not found."
    end
  
    redirect_to admin_maintenance_comments_path
  end

  private
  def maintenance_comment_params
    params.require(:maintenance_comment).permit(:comment)
  end
end
