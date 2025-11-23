class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.without_guest
    @user = current_user
  end

  def show
    @user = User.unscoped.find(params[:id])
  
    if @user.deleted?
      redirect_to root_path, notice: "このユーザーは退会しています。"
      return
    end
  
    @current_user = current_user
    @cars = @user.cars
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      if @user.update(user_params)
        flash[:notice] = "ユーザー情報を正常に更新しました。"
        redirect_to user_path(@user)
      else
        flash[:notice] = "ユーザー情報を正常に更新できませんでした。"
        render :edit
      end
    else
      redirect_to user_path(current_user), alert: "このユーザー情報を編集する権限がありません。"
    end
  end

  def un
    @user = current_user
    @user.soft_delete
    sign_out @user
    redirect_to root_path, notice: "ユーザー情報の削除が完了しました。  ログアウトしました。"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :profile_image, :introduction,)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面にアクセスできません。  ログアウト後,新規登録してください。"
    end
  end

end
