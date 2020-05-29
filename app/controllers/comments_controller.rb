class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @post = @comment.post
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:notice] = 'コメントを投稿しました!'
      redirect_to post_path(@post)
    else
      flash[:error_messages] = @comment.errors.full_messages
      render 'posts/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.post, flash: { notice: 'コメントが削除されました' }
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
