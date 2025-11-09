class Public::RequestsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @request = current_user.requests.build(group: @group, status: 'pending')
    if @request.save
      redirect_to @group, notice: 'Request sent successfully.'
    else
      redirect_to @group, alert: 'Failed to send request.'
    end
  end

  def update
    request = Request.find(params[:id])
    
    if current_user.id == request.group.owner_id
      if request.update(status: params[:status])
        if params[:status] == 'approved'
          request.destroy
          request.group.users << request.user
        end
        redirect_to request.group, notice: 'Request status updated.'
      else
        redirect_to request.group, alert: 'Failed to update request status.'
      end
    else
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
