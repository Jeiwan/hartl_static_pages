class User < ActiveRecord::Base
	has_secure_password

	# attr_accessor :password, :password_confirmation

	before_save :encrypt_password
	before_save { self.email = email.downcase }

	validates_presence_of :name, :email, :password, :password_confirmation
	validates :name, length: { in: 3..32 }
	validates :email, uniqueness: { case_sensitive: false }
	validates :password, confirmation: true, length: { in: 6..32 }

	private

	def encrypt_password
		if password && password_confirmation && password == password_confirmation
			self.password_digest = BCrypt::Password.create(password)
		end
	end
end
