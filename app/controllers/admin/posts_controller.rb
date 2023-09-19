class Admin::PostsController < ApplicationController
  def index
    if params[:category_id]
    	@category = Category.find(params[:category_id])
    	@category_posts = @category.posts
    else
    	@posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
  end
    
  
end
