class Admin::PostsController < ApplicationController
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
  end
    
  
end
