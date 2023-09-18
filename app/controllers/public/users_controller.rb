class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def check
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
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
  
  def post_likes
    @user = User.find(params[:id])
    post_likes= PostLike.where(user_id: @user.id).pluck(:post_id)
    @post_like_posts = Post.find(post_likes)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:user_image, :name, :profile, :email)
  end
end
