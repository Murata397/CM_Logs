class Public::FuelEfficiencyController < ApplicationController
  before_action :authenticate_user!

  def new
    @fuel_efficiency = FuelEfficiency.new
  end

  def create
    @fuel_efficiency = FuelEfficiency.new(fuel_efficiency_params)
    @fuel_efficiency.user_id = current_user.id

    if @fuel_efficiency.save
      flash[:notice] = "You have cerated fuel_efficiency successfully."
      redirect_to fuel_efficiency_path(@fuel_efficiency)
    else
      flash[:notice] = "You  have not created fuel_efficiency successfully"
      render 'new'
    end
  end

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @fuel_efficiencies = @user.fuel_efficiencies.includes(:car)
    else
      @fuel_efficiencies = current_user.fuel_efficiencies.includes(:car)
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
      flash[:notice] = "You cannot renew another user's fuel_efficiency"
      redirect_to fuel_efficiency_path(@fuel_efficiency)
    end
  end

  def update
    @fuel_efficiency = FuelEfficiency.find(params[:id])
    if @fuel_efficiency.update(fuel_efficiency_params)
      flash[:notice] = "You have update fuel_efficiency successfully"
      redirect_to @fuel_efficiency
    else
      flash[:notice] = "You have not update fuel_efficiency successfully"
      render 'edit'
    end
  end

  def destroy
    @fuel_efficiency = FuelEfficiency.find(params[:id])
    if @fuel_efficiency.user == current_user
      @fuel_efficiency.destroy
      redirect_to fuel_efficiency_path, notice: "Fuel_Efficiency deleted"
    else
      redirect_to fuel_efficiency_path, alert: "You do not have permission to delete other user's fuel_efficiency."
    end
  end

  private

  def fuel_efficiency_params
    params.require(:fuel_efficiency).permit(:user_id, :car_id, :title, :refuelin_day, :odometer, :tripmeter, :fuel, :fuel_efficiency, :fuel_type)
  end

end
