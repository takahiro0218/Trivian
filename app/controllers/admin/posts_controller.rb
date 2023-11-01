class Admin::PostsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    if params[:category_id]
    	@category = Category.find(params[:category_id])
    	@category_posts = @category.posts.page(params[:page])
    else
    	@posts = Post.page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments.page(params[:page])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to request.referer
    end
  end


end
