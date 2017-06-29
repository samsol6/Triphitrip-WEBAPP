class Api::V1::RegistrationsController < Api::ApiController
	
respond_to :json
skip_before_action :verify_authenticity_token
before_action :check_user, only: [:create]



# changed packet trasformation from params[:user][:email] to params[:email]

	def create    
		if params[:email].blank? || params[:password].blank? || params[:password_confirmation].blank?      
			render json: {status: "failed", message: "Missing Parameters"}    
		else      
			# if request.headers["Authorization"].blank?
			#     user = User.new(user_params)
			#     if user.save
			#     	render json: {status: "successful", 
			# 		    			user: { id: user.id, 
			# 		    			email: user.email,
			# 		    			created_at: @user.created_at, 
			# 		    			updated_at: @user.updated_at }}

			#     else
			#         render json: {status: "failed", user: user.errors}        
			#     end      
			# else   
			    if  User.exists?(email: params[:email])
			    	user = User.find_by(email: params[:email])
			    	user.update(user_params)
			    	render json: {status: "successful", 
			    					user: { id: user.id, 
			    						email: user.email, 
			    						created_at: user.created_at, 
			    						updated_at: user.updated_at }}

			    else          
			    	user = User.new(user_params)
			    	# user.authentication_token = request.headers["Authorization"]
			    	# user.password = params[:user][:email]
			    	# user.password = params[:user][:password]
			    	# user.password_confirmation = params[:user][:password_confirmation]
			    	# image_file = Paperclip.io_adapters.for(params[:user][:picture])
			    	# image_file.original_filename = "#{set_image_name}.png"
			    	# user.picture = image_file
			    	if user.save
			    		render json: {status: "successful", 
			    						user: { id: user.id,
			    							email: user.email,
			    							created_at: user.created_at,
			    							updated_at: user.updated_at }}
			    	else
			    	    render json: {status: "failed", user: user.errors}
			    	end
			    end
			# end
		end
	end

	private  

	def user_params    
		# params.require(:user).permit(:email,:password,:password_confirmation)  
		params.permit(:email,:password,:password_confirmation)  
	end  

	def check_user
		if User.exists?(email: params[:email])
			render  json: {status: "failed", message: "User Already Exists"}    
		end
	end  


	# def set_image_name 
	#    random_number = SecureRandom.base64  
	# end
  
end
