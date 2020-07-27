class HomeController < ApplicationController
  def index
    @recent_posts = Post.all.order(created_at: :desc).limit(3)
  end
end
