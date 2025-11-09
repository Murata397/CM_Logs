class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group =Group.new
  end

  def index
    @groups =Group.all
  end

  def show
    @group = Group.find(params[:id])
    @owner_user = User.find(@group.owner_id)
    @requests = @group.requests
  end

  def create
    @group =Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    
    if @group.update(group_params)
      if params[:status] == 'approved'
        request = Request.find(params[:request_id])
        @group.users << request.user
        request.destroy
      end
      redirect_to @group, notice: 'Group updated.'
    else
      render 'edit'
    end
  end

  def remove_member
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
  
    if @group.is_owner_by?(current_user) && @group.users.exists?(@user.id)
      @group.users.delete(@user)
      redirect_to @group, notice: 'The user was removed from the group.'
    else
      redirect_to @group, alert: 'Operation not permitted.'
    end
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :group_introduction, :group_image, :group_theme, :group_rules)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end