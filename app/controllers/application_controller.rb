class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #to redirect to the sign in page from any other page
  before_action :authenticate_user!
end
