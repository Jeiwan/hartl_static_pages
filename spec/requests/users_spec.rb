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
end