class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def calculate_piece_rating(reviews)
    sum = 0.0
    reviews.each do |review|
      sum+=review.rating
    end
    sum/reviews.length
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :profile_photo]
    devise_parameter_sanitizer.for(:account_update) << [:avatar]
  end

  def signed_in_flash
    if !user_signed_in?
      flash.now[:error] = "Please sign in first"
    end
  end

  def authorize_member
    if user_signed_in? && !current_user.admin?
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
