class Public::PostLikesController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    post_like = current_user.post_likes.new(post_id: post.id)
    post_like.save
    redirect_to request.referer
  end
  
  def destroy
    post = Post.find(params[:post_id])
    post_like = current_user.post_likes.find_by(post_id: post.id)
    post_like.destroy
    redirect_to request.referer
  end
  
end
