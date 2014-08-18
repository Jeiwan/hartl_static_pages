require 'rails_helper'

RSpec.describe "Microposts", :type => :request do
	describe "on user's profile page" do
		subject { page }
		let(:user) { FactoryGirl.create(:user) }
		# before { visit user_path(user.id) }

		# it { should have_selector('ul.b-micorposts') }
		# describe "on user's profile page" do
		# 	before { visit user_path(user.id) }

		# 	it { should have_selector('form') }
		# end	

		describe "post new micropost" do
			before do
				visit login_path
				sign_in user
				# visit user_path(user.id)
				fill_in 'micropost_post', with: 'Hello, world!'
				click_button 'Post'
			end

			it { should have_title user.name }
			it { should have_content 'Posted!' }
			it { should have_content 'Hello, world!' }
			# it { should have_selector('form') }

			describe "with excessive post length" do
				before do
					visit login_path
					sign_in user
					fill_in 'micropost_post', with: 'a'*141
					click_button 'Post'
				end

				it { should have_content 'Wrong message length!' }
			end
		end
	end
end
