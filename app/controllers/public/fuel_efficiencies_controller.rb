class Public::FuelEfficienciesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, except: []

  def new
    @fuel_efficiency = FuelEfficiency.new
  end

  def create
    @fuel_efficiency = FuelEfficiency.new(fuel_efficiency_params)
    @fuel_efficiency.user_id = current_user.id

    if @fuel_efficiency.save
      flash[:notice] = "燃費情報の登録に成功しました。"
      redirect_to fuel_efficiency_path(@fuel_efficiency)
    else
      flash[:notice] = "燃費情報の登録に失敗しました。"
      render 'new'
    end
  end

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @fuel_efficiency = @user.fuel_efficiency.includes(:car)
    else
      @fuel_efficiency = current_user.fuel_efficiency.includes(:car)
    end
  end

  def show
    @fuel_efficiency = FuelEfficiency.find(params[:id])
    calculate_fuel_efficiency
    @user = @fuel_efficiency.user
    @fuel_efficiency_new = FuelEfficiency.new
  end

  def edit
    @fuel_efficiency = FuelEfficiency.find(params[:id])
    if @fuel_efficiency.user != current_user
      flash[:notice] = "他ユーザーの燃費情報を編集することはできません。"
      redirect_to fuel_efficiency_path(@fuel_efficiency)
    end
  end

  def update
    @fuel_efficiency = FuelEfficiency.find(params[:id])
    if @fuel_efficiency.update(fuel_efficiency_params)
      flash[:notice] = "燃費情報を更新しました。"
      redirect_to @fuel_efficiency
    else
      flash[:notice] = "燃費情報を更新できませんでした。"
      render 'edit'
    end
  end

  def destroy
    @fuel_efficiency = FuelEfficiency.find(params[:id])
    if @fuel_efficiency.user == current_user
      @fuel_efficiency.destroy
      redirect_to fuel_efficiencies_path, notice: "燃費情報を削除しました。"
    else
      redirect_to fuel_efficiencies_path, alert: "他ユーザーの燃費情報を削除することはできません。"
    end
  end

  def check_guest_user
    if current_user && current_user.guest_user?
      redirect_to @current_user, notice: "ゲストユーザーはこの操作を実行できません。  ログアウト後、新規登録してください。"
    end
  end

  private

  def fuel_efficiency_params
    params.require(:fuel_efficiency).permit(:user_id, :car_id, :refuelin_day, :odometer, :tripmeter, :fuel, :fuel_efficiency, :fuel_type)
  end

end
