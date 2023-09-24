class Public::HomesController < ApplicationController
  
  before_action :authenticate_user!, only: [:top]
  
  def top
    if params[:category_id]
    	@category = Category.find(params[:category_id])
    	@category_posts = @category.posts.page(params[:page])
    else
    	@posts = Post.page(params[:page]).order(created_at: :desc)
    end
  end

  def about
  end
  
end
