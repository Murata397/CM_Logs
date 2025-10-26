class Public::CarsController < ApplicationController

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user_id = current_user.id
    
    if @car.save
      flash[:notice] = "You have created car successfully"
      redirect_to car_path(@car)
    else
      flash[:natice] = "You have not created cat successfully"
      render 'new'
    end
  end

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @user = @car.user
    @car_new = Car.new
  end

  def edit
    @car = Car.find(params[:id])
    if @car.user != current_user
      flash[:notice] = "You cannot renew another use's car."
      redirect_to cars_path
    end
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      flash[:notice] = "You have update car successfully"
      redirect_to @car
    else
      flash[:notice] = "You have not update car successfully"
      render 'index'
    end
  end

  def destroy
    @car = Car.find(params[:id])
    if @car.user == current_user
      @car.destroy
      redirect_to car_path, notice: "Car deleted"
    else
      redirect_to car_path, alert: "You do not have permission to delete other user's car."
    end
  end

  private

  def car_params
    params.require(:car).permit(:car_image, :manufacturer_name, :car_model, :odometer, :purpose)
  end
end
