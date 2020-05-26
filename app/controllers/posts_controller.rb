class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    if @post.save(post_params)
      flash[:notice] = "投稿しました!"
      redirect_to user_path(current_user)
    else
      flash[:error_messages] = @post.errors.full_messages
      render 'new'
    end
  end

  def update
    @post.update(post_params)
    flash[:notice] = "更新しました!"
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "削除しました!" }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id,
                                 :shop_name,
                                 :review,
                                 :date,
                                 :electrical_outlet,
                                 :image,
                                 :open_time,
                                 :end_time,
                                 :phone_number,
                                 :price,
                                 :rating,
                                 :review,
                                 :smoking_seat,
                                 :street_address,
                                 :url,
                                 :wifi)
  end
end
