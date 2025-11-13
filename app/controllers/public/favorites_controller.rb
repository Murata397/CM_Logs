class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest_user, except: []

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

def check_guest_user
  if current_user && current_user.guest_user?
    redirect_to @current_user, notice: "ゲストユーザーはこの操作を実行できません。  ログアウト後、新規登録してください。"
  end
end