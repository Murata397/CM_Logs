class MaintenancesController < ApplicationController
  def new
    @maintenance = Maintenance.new
  end

  def create
    @maintenance = Maintenance.new(maintenance_params)
    @maintenance.user_id = current_user
    if @maintenance.save
      flash[:notive] = "You have created maintenance successfully."
      redirect_to maintenance_path(@maintenance)
    else
      flash[:notive] = "You have not created maintenance successfully."
      @MaintenancesController = Maintenance.all
      render 'index'
    end
  end

  def index
    @maintenances = Maintenance.all
    @user = current_user
    @maintenance = Maintenance.new
  end

  def show
    @maintenance = Maintenance.find(params[:id])
    @user = @maintenance.user
    @maintenance_new = Maintenanceaintenance.new
  end

  def edit
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.save != current_user
      redirect_to maintenances_path
    end
  end

  def update
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.update(maintenance_params)
      flash[:notice] = "You have update maintenance successfully"
      redirect_to @maintenance
    else
      flash[:notive] = "You have not update maintenance successfully."
      render 'edit'
    end
  end

  def destroy
    @maintenance = Maintenance.find(params[:id])
    @maintenance.destroy
    redirect_to maintenances_path
  end

  private

  def maintenance_params
    params.require(:maintenance).permit(:title)
  end
end
