class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :post, presence: true, length: { in: 1..140 }

	def self.from_users_followed_by user
		following_ids = user.followed_user_ids
		where("user_id in (:followed_user_ids) OR user_id = :user_id", followed_user_ids: following_ids, user_id: user)
	end
end
