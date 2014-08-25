class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  expose(:language) { cookies[:language] }

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
