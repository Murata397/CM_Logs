class Public::CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, except: [:index, :show]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user_id = current_user.id
    
    if @car.save
      flash[:notice] = "車両の登録に成功しました。"
      redirect_to car_path(@car)
    else
      flash[:natice] = "車両の登録に失敗しました。"
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
      flash[:notice] = "他ユーザーの車両情報を更新することはできません。"
      redirect_to cars_path(@car)
    end
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      flash[:notice] = "車両情報を更新しました。"
      redirect_to @car
    else
      flash[:notice] = "車両情報を更新できませんでした。"
      render 'edit'
    end
  end

  def destroy
    @car = Car.find(params[:id])
    if @car.user == current_user
      @car.destroy
      redirect_to cars_path, notice: "登録車両を削除しました。"
    else
      redirect_to cars_path, alert: "他ユーザーの登録車両を削除することはできません。"
    end
  end

  def check_guest_user
    if current_user && current_user.guest_user?
      redirect_to @current_user, notice: "ゲストユーザーはこの操作を実行できません。  ログアウト後、新規登録してください。"
    end
  end

  private

  def car_params
    params.require(:car).permit(:car_image, :manufacturer_name,:car_name, :car_model, :odometer, :purpose)
  end
end
