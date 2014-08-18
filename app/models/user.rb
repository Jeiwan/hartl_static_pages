class User < ActiveRecord::Base
	has_secure_password
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
	has_many :reverse_relationships, foreign_key: 'followed_id', class_name: "Relationship", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :followers, through: :reverse_relationships

	before_save :encrypt_password
	before_save { email.downcase! }

	validates_presence_of :name, :email, :password, :password_confirmation
	validates :name, length: { in: 3..32 }
	validates :email, uniqueness: { case_sensitive: false }
	validates :password, confirmation: true, length: { in: 6..32 }

	def feed
		Micropost.from_users_followed_by(self)
	end

	def follow! user_to_follow
		relationships.create!(followed_id: user_to_follow.id) if user_to_follow
	end

	def following? user_to_follow
		relationships.find_by(followed_id: user_to_follow.id) if user_to_follow
	end

	def unfollow! user_to_unfollow
		relationships.find_by(followed_id: user_to_unfollow.id).destroy if user_to_unfollow
	end

	private

	def encrypt_password
		if password && password_confirmation && password == password_confirmation
			self.password_digest = BCrypt::Password.create(password)
		end
	end
end
