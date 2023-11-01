class Public::PostsController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @post = Post.new
    @category = Category.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page])
  end
  
  def create
    @post = Post.new(post_params)
    # !つけたらエラーになるけどなんで？
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to root_path
    else
      @category = Category.all
      render :new
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to request.referer
    end
  end
  
  def ranking
    @posts = Post.find(PostLike.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :text, :post_image, :category_id)
  end
  
end
