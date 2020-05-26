class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:show, :create, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result(distinct: true).page(params[:page])
                    .per(20).order(created_at: :desc)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:user_name, :image, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
