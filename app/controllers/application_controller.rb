class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::UnpermittedParameters, with: :render_unpermitted_params

  def render_404
    render file: 'public/404.json', status: 404
  end

  private

  def render_unpermitted_params(e)
    render json: { message: e.message }, status: 422
  end
end
