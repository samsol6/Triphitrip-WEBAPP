class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :default_values

	def default_values
    	self.role = role.presence || 'user'
  end

  def self.to_csv
    attributes = %w{first_name last_name email contact}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        # csv << attributes.map{ |attr| user.send(attr) }
        csv << user.attributes.values_at(*attributes)
      end
    end
  end


end
