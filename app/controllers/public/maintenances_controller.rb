class Public::MaintenancesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :check_guest_user, except: [:index, :show]
  def new
    @maintenance = Maintenance.new
  end

  def create
    @maintenance = Maintenance.new(maintenance_params)
    @maintenance.user_id = current_user.id

    if @maintenance.save
      flash[:notice] = "メンテナンス情報の登録に成功しました。"
      redirect_to maintenance_path(@maintenance)
    else
      flash[:notice] = "メンテナンス情報の登録に失敗しました。"
      render 'new'
    end
  end

  def index
    @maintenances = Maintenance.all
    @maintenances = Maintenance.includes(:car).all
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @maintenances = @user.maintenances
    else
     render 'index'
    end
  end

  def show
    @maintenance = Maintenance.find(params[:id])
    @user = @maintenance.user
    @maintenance_new = Maintenance.new
    @maintenance_comment = MaintenanceComment.new
    @maintenances = Maintenance.includes(:car).all
  end

  def edit
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.user != current_user
      flash[:notice] = "他ユーザーのメンテナンス情報を編集することはできません。"
      redirect_to maintenances_path(@maintenance)
    end
  end

  def update
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.update(maintenance_params)
      flash[:notice] = "メンテナンス情報の更新に成功しました。"
      redirect_to @maintenance
    else
      flash[:notice] = "メンテナンス情報の更新に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.user == current_user
      @maintenance.destroy
      redirect_to maintenances_path, notice: "メンテナンス情報を削除しました。"
    else
      redirect_to maintenances_path, alert: "他ユーザーのメンテナンス情報は削除できません。"
    end
  end

  def check_guest_user
    if current_user && current_user.guest_user?
      redirect_to @current_user, notice: "ゲストユーザーはこの操作を実行できません。  ログアウト後、新規登録してください。"
    end
  end

  private

  def maintenance_params
    params.require(:maintenance).permit(:title, :maintenance_day, :maintenance, :work_difficulty, :work_time, :work_pay, :tool_images, :images , :related_information, :work_description, :car_id)
  end
end
