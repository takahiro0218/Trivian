class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
    @category = Category.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def create
    @post = Post.new(post_params)
    # !つけたらエラーになるけどなんで？
    if @post.save!
      flash[:notice] = "投稿しました"
      redirect_to root_path
    else
      @category = Category.all
      render :new
    end
  end
  
  def destory
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :text, :post_image, :category_id)
  end
  
end
