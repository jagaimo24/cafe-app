class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @favorite_posts = @user.favorite_posts
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20)
    render 'relationships/show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    render 'relationships/show_follow'
  end
end
