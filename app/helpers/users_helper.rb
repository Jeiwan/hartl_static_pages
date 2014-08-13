require 'digest'
require 'open-uri'

module UsersHelper
	def gravatar_for user, options = { size: 80 }
		image_tag "http://gravatar.com/avatar/#{Digest::MD5.hexdigest user.email.downcase}?s=#{options[:size]}", alt: user.name, class: "gravatar #{ "admin" if user.admin?}", size: "#{options[:size]}x#{options[:size]}" unless user.email.nil?
	end
end
