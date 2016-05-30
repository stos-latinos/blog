class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from Exception, with: :render_error

  protected

  def render_error(e)
    render json: { error: e.message }, status: 500
  end
end
