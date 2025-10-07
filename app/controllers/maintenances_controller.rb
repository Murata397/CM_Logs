class MaintenancesController < ApplicationController
  def new
    @maintenance = Maintenance.new
  end

  def create
    @maintenance = Maintenance.new(maintenance_params)
    @maintenance.user_id = current_user.id


    if @maintenance.save!
      flash[:notice] = "You have created maintenance successfully."
      redirect_to maintenance_path(@maintenance)
    else
      flash[:notice] = "You have not created maintenance successfully."
      render 'new'
    end
  end

  def index
    @maintenances = Maintenance.all
  end

  def show
    @maintenance = Maintenance.find(params[:id])
    @user = @maintenance.user
    @maintenance_new = Maintenance.new
  end

  def edit
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.user != current_user
      redirect_to maintenances_path
    end
  end

  def update
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.update(maintenance_params)
      flash[:notice] = "You have update maintenance successfully"
      redirect_to @maintenance
    else
      flash[:notice] = "You have not update maintenance successfully."
      render 'index'
    end
  end

  def destroy
    @maintenance = Maintenance.find(params[:id])
    @maintenance.destroy
    redirect_to maintenances_path
  end

  private

  def maintenance_params
    params.require(:maintenance).permit(:title, :maintenance_day, :maintenance, :work_difficulty, :work_time, :work_pay, :tool_images, :images , :related_information, :work_description)
  end
end
