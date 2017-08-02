class Api::V1::SessionsController < Api::ApiController

# Api JSON Authentication with Devise
# https://gist.github.com/jwo/1255275
#
  
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :ensure_params_exist, only: [:create]

# changed packet trasformation from params[:user][:email] to params[:email]

  def create

  	resource = User.find_for_database_authentication(email: params[:email])
  	return invalid_login_attempt unless resource

  		if resource.valid_password?(params[:password])
  			sign_in("user", resource)
  			render json: {status: "successful", user:{id: resource.id,
  				email: resource.email,
          authentication_token: resource.authentication_token,
          role: resource.role,
          first_name: resource.first_name,
          last_name: resource.last_name,
  				# authentication_token: resource.authentication_token,
  				created_at: resource.created_at,
  				updated_at: resource.updated_at  }}
  			return
  		end
  	invalid_login_attempt
  end

  def destroy
  	#signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  	signed_out = sign_out
  	if signed_out
  		render json: {status: "successful",msg: "You have signed out sucessfully"}
  	else
  		render json: {status: "failed",msg: "User Not signed in"}
  	end
  end

  protected

  def ensure_params_exist
  	return unless params[:email].blank? || params[:password].blank?
  		render json: {status: "failed", message: "Missing User Parameters"}
  end

  def invalid_login_attempt
  	#warden.custom_failure!
  		render json: {status: "failed", message: "Error with your Email or Password"}
  end


end
