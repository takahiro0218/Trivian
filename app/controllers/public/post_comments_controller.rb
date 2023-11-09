class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    if comment.save
      # redirect_to request.referer
      flash[:notice] = "コメントを投稿しました"
    else
      # redirect_to request.referer
      flash[:notice] = "コメントを入力してください"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
    flash[:notice] = "コメントを削除しました"
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
