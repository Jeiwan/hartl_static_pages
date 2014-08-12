require 'bcrypt'
FactoryGirl.define do
	factory :user do
		name "Sancho Panza"
		email "sancho@panza.es"
		password "dfgcvb"
		password_confirmation "dfgcvb"
		password_digest BCrypt::Password.create('dfgcvb')
	end
end