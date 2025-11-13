class Public::RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :check_guest_user, except: []


  def create
    @group = Group.find(params[:group_id])
    @request = current_user.requests.build(group: @group, status: 'pending')
    if @request.save
      redirect_to @group, notice: 'リクエストは正常に送信されました。'
    else
      redirect_to @group, alert: 'リクエストの送信に失敗しました。'
    end
  end
  
  def update
    request = Request.find(params[:id])
    
    if current_user.id == request.group.owner_id
      if request.update(status: params[:status])
        if params[:status] == 'approved'
          request.destroy
          request.group.users << request.user
        elsif params[:status] == 'rejected'
          request.destroy
        end
        redirect_to request.group, notice: 'リクエストステータスが更新されました。'
      else
        redirect_to request.group, alert: 'リクエストステータスの更新に失敗しました。'
      end
    else
      redirect_to group_path(request.group.id), flash: { alert: 'この操作を実行する権限がありません。' }
    end
  end

  def check_guest_user
    if current_user && current_user.guest_user?
      redirect_to @current_user, notice: "ゲストユーザーはこの操作を実行できません。  ログアウト後、新規登録してください。"
    end
  end
end