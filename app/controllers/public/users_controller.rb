class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def check
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user = current_user
      if @user.valid_password?(params[:user][:current_password])
        if @user.update(user_params)
          redirect_to user_path(@user.id)
          flash[:notice] = "アカウント情報を変更しました"
        else
          render :edit
        end
      else
        flash[:notice] = "パスワードが違います"
        render :edit
      end
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

  def post_likes
    @user = current_user
    post_likes= PostLike.where(user_id: @user.id).pluck(:post_id)
    @post_like_posts = Post.where(id: post_likes).page(params[:page])
  end


  private

  def user_params
    params.require(:user).permit(:user_image, :name, :profile, :email)
  end
end
