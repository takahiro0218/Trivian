class Public::UsersController < ApplicationController
  
  def show
    @user = current_user
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def check
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def destroy
    @user = current_user
    if @user.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to new_user_registration_path
    else
      redirect_to request.referer
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:user_image, :name, :profile, :email)
  end
end
