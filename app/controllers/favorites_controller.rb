class FavoritesController < ApplicationController
  def create
    maintenance = Maintenance.find(params[:maintenance_id])
    favorite = current_user.favorites.new(maintenance_id: maintenance.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    maintenance = Maintenance.find(params[:maintenance_id])
    favorite = current_user.favorites.find_by(maintenance_id: maintenance.id)
    favorite.destroy
    redirect_to request.referer
  end
end
