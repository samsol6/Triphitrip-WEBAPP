# Preview all emails at http://localhost:3000/rails/mailers/rezlist_mailer
class RezlistMailerPreview < ActionMailer::Preview
	
	def sample_mail_preview
	    RezlistMailer.sample_email(User.first)
	end

end
