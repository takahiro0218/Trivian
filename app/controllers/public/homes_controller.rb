class Public::HomesController < ApplicationController
  def top
    if params[:category_id]
    	@category = Category.find(params[:category_id])
    	@category_posts = @category.posts
    else
    	@posts = Post.all
    end
  end

  def about
  end
end
