class Public::RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow(current_user)
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(20)
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(20)
  end
  
end
