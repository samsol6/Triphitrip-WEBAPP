class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  	before_save :default_values
	# after_initialize :default_values

	def default_values
    	self.role = role.presence || 'user'
    	# self.role ||= "user"
  	end
end
