require 'digest'
require 'open-uri'

module UsersHelper
	def gravatar_for user
		image_tag "http://gravatar.com/avatar/#{Digest::MD5.hexdigest user.email.downcase}", alt: user.name, class: 'gravatar' unless user.email.nil?
	end
end
