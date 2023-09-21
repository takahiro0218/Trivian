class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_user_path(@user.id)
    else
      render :edit
    end
  end
  
  # 必要ないかも
  # def ban
  #   @user = User.find(params[:user_id])
  #   if @user.update(user_status: true)
  #     reset_session
  #     flash[:notice] = "アカウントを停止しました"
  #     redirect_to admin_user_path(@user.id)
  #   end
  # end
  
  
  private
  
  def user_params
    params.require(:user).permit(:id, :name, :email, :user_status, :user_image, :profile)
  end
  
end
