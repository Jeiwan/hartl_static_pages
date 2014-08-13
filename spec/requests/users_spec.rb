require 'rails_helper'

RSpec.describe "Users", :type => :request do
	subject { page }
	describe 'signup page' do
		before { visit signup_path }
		it { should have_title('Sign Up') }
		it { should have_content('Sign Up') }
		it { should have_selector('form') }
	end

	describe 'new user registration' do
		before { visit signup_path }
		it "should be accomplished" do
			within('#new_user') do
				fill_in('Name', with: 'Pedro')
				fill_in('Email', with: 'pedro@pedro.com')
				fill_in('Password', with: 'asdzxc')
				fill_in('Password Confirmation', with: 'asdzxc')
				expect { click_button('Sign Up') }.to change(User, :count)
			end
		end
	end	

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		it { should have_title(user.name) }
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			visit settings_path
			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button 'Log In'
		end
		subject { page }
		describe "page" do
			it { should have_title('Edit Profile') }
			it { should have_content('Edit Profile') }
			it { should have_link('Change avatar', href: 'http://gravatar.com/emails') }
		end

		describe "with invalid information" do
			before { click_button "Save changes" }

			it { should have_content 'Error!' }
		end

		describe "with valid information" do
			before do
				fill_in 'Name', with: user.name + ('a'..'z').to_a.shuffle[0..4].join
				fill_in 'Email', with: user.email
				fill_in 'Password', with: user.password
				fill_in 'Password confirmation', with: user.password_confirmation
				click_button 'Save changes'
			end

			it { should have_content 'Updated!' }
		end
	end

	describe "users page" do
		subject { page }
		before { visit users_path }
		it { should have_title 'All Users' }
	end

	describe "index" do
		before do
			# let FactoryGirl.create(:user)
			visit users_path
		end
		it { should have_title 'All Users' }
		it { should have_content 'All Users' }

		# describe "pagination" do
		# 	before(:all) { 30.times { FactoryGirl.create(:user) } }
		# 	after(:all) { User.delete_all }
		# 	it "should list each user" do
		# 		User.order(:id).paginate(page: 1, per_page: 10).each do |user|
		# 			expect(page).to have_selector('h2', text: user.name)
		# 		end
		# 	end
		# end

		describe "delete link" do
			before(:all) { 3.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }
			before { visit users_path }

			it { should_not have_link 'delete user' }

			describe "as an admin user" do
				subject { page }
				let(:admin) { FactoryGirl.create(:admin) } 
				before do
					sign_in admin
					visit users_path
				end

				it { should have_title 'All Users' }
				it { should have_content "EVIL ADMIN'S HERE" }
				it { should have_content 'delete user' }
				it "should be able to delete another user" do
					expect do
						click_link 'delete user', match: :first
					end.to change(User, :count).by(-1)
				end
			end
		end
	end
end