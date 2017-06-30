class Api::V1::ExportsController < Api::ApiController

respond_to :json
skip_before_action :verify_authenticity_token
# before_action :check_user, only: [:create]


	# def index
	#     @users = User.all

	#     respond_to do |format|
	#       format.html
	#       format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
 #    	end

 #    	ActionMailer::Base.mail(from: "talha@hotmail.com", to: "talhawaheed92@gmail.com", subject: "test", body: "test").deliver
 #    end


	def index

		@users = User.all
		csv = @users.to_csv
		# email = params[:email]
		# email = "talhawaheed92@gmail.com"
		@data = User.last
		@data.email=params[:email]
		RezlistMailer.sample_email(@data).deliver
		# JobMailer.send_csv(email, csv).deliver
		render json: {status: "successful", user:{id: @data.id, email: @data.email }}
	end

	def send_csv(email, csv)
		attachments['my_file_name.csv'] = {mime_type: 'text/csv', content: csv}
		mail(to: email, subject: 'My subject', body: 'My body.')
	end

	def user_params    
		# params.require(:user).permit(:email,:password,:password_confirmation)  
		params.permit(:email)  
	end  
end