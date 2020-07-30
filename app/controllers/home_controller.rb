class HomeController < ApplicationController
  def index
    @recent_posts = Post.all.order(created_at: :desc).limit(3)
    @higher_rank = Post.create_higher_rank
  end
end
