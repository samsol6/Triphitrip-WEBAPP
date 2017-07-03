class Api::V1::ExportsController < Api::ApiController

# require 'mailgun'
require 'base64'
require 'sendgrid-ruby'
include SendGrid

respond_to :json
skip_before_action :verify_authenticity_token


	# def index
	#     @users = User.all

	# 	respond_to do |format|
	#       format.html
	#       format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
	# 	end
	# end
	
	
	# def index
		

	# 	@users = User.all
	# 	csv = @users.to_csv

	# 	file = Tempfile.new('name')
	# 	file.write(csv)
	# 	file.rewind

	# 	#Your Credentials for MailGun
	# 	api_key = 'key-38097e04ba2b86dbfa2eca20f81e5b55'
	# 	sending_domain = 'sandboxd4cb237c3f244c2f88e631e0e7772782.mailgun.org'

	# 	# First, instantiate the Mailgun Client with your API key
	# 	mg_client = Mailgun::Client.new api_key

	# 	# Define your message parameters

	# 	mb = Mailgun::MessageBuilder.new
	#     mb.set_from_address("admin@rezlist.com")
	#     mb.add_recipient(:to, params[:email])
	#     mb.set_subject("Users CSV")
	#     mb.set_text_body("Please find the attachment")
	#     # mb.set_html_body("<html><body><h3>Look at attachments</h3></body></html>")
	#     mb.add_attachment(file.path, 'users.csv') # first arg is path to the file, second is filename as an attachment
	    
	# 	# Send your message through the client
	# 	result  = mg_client.send_message sending_domain, mb #message_params
	# 	render json: result.body
	# 	file.unlink
	# end


	def index
		
		@users = User.all
		csv = @users.to_csv

		file = Tempfile.new('name')
		file.write(csv)
		file.rewind

		cnt = Base64.encode64(File.open(file.path, "rb").read)
		if cnt.include?("\n")
			puts "========************************==========="
			cnt ["\n"] = "" 
			puts "========************************==========="
		end
	
		# using SendGrid's Ruby Library
		# https://github.com/sendgrid/sendgrid-ruby

		from = Email.new(email: 'Admin@rezlist.com')
		to = Email.new(email: params[:email])
		subject = 'CSV data for TopProducer'
		content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
		mail = Mail.new(from, subject, to, content)

		attachment = Attachment.new
		attachment.content = cnt
		attachment.type = 'application/text'
		attachment.filename = 'users.csv'
		attachment.disposition = 'attachment'
		attachment.content_id = 'Users Export'
		mail.add_attachment(attachment)

		puts "==================================================================="
		puts mail.to_json
		puts "==================================================================="

		sg = SendGrid::API.new(api_key: SENDGRID_API_KEY)
		response = sg.client.mail._('send').post(request_body: mail.to_json)
		puts response.status_code
		puts response.body
		puts response.headers

		file.unlink
	end




	def user_params    
		# params.require(:user).permit(:email,:password,:password_confirmation)  
		params.permit(:email)  
	end  
end