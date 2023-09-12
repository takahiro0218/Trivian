class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def show
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def destory
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:post_image, :text)
  end
  
end
