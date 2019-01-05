class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session

  def set_current_user(user_data)
  	session[:current_user]=user_data
  end
end
