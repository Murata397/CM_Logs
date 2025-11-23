class Admin::MaintenancesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @maintenances = Maintenance.unscoped.all
  end

  def show
    @maintenance = Maintenance.find(params[:id])
    @maintenance_comments = @maintenance.maintenance_comments.with_deleted
  end


  def destroy
    @maintenance = Maintenance.find(params[:id])
    @maintenance.soft_delete
    redirect_to admin_maintenances_path, notice: "メンテナンス情報の削除に成功しました。"
  end

  def deleted_index
    @maintenances = Maintenance.unscoped.where.not(deleted_at: nil)
  end

  def restore
    @maintenance = Maintenance.unscoped.find(params[:id])
    @maintenance.restore
    redirect_to admin_maintenances_path, notice: "メンテナンスを復元しました"
  end

  private

  def maintenance_params
    params.require(:maintenance).permit(:title, :maintenance_day, :maintenance, :work_difficulty, :work_time, :work_pay, :tool_images, :images, :related_information, :work_description, :car_id)
  end
end