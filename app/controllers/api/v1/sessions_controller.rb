class Api::v1::SessionsController < Api::ApiController
  
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_filter :ensure_params_exist, only: [:create]



  def create
  	resource = User.find_for_database_authentication(email: params[:user][:email])
  		return invalid_login_attempt unless resource
  		if resource.valid_password?(params[:user][:password])
  			sign_in("user", resource)
  			render json: {status: "successful", user:{id: resource.id,
  				email: resource.email,
  				# first_name: resource.first_name,
  				# last_name: resource.last_name,
  				# age: resource.age,
  				# phone: resource.phone,
  				# location: resource.location,
  				# picture: resource.picture,
  				# authentication_token: resource.authentication_token,
  				created_at: resource.created_at,
  				updated_at: resource.updated_at  }}
  				return
  		end
  	invalid_login_attempt
  end

  def destroy
  end

  def ensure_params_exist
  	return unless params[:user].blank?
  		render json: {status: "failed", message: "Missing User Parameters"}
  end

  def invalid_login_attempt
  	warden.custom_failure!
  		render json: {status: "failed", message: "Error with your Email or Password"}
  end


end
