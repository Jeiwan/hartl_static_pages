require 'rails_helper'

RSpec.describe "Sessions", :type => :request do
	subject { page }
	describe 'log in page' do
		before { visit login_path }
		it { should have_title('Log In') }
		it { should have_selector('form') }
	end
	describe "log in" do
		before { visit login_path }
		describe "with invalid information" do
			before { click_button('Log In') }
			it { should have_selector('p.alert.alert-danger') }
		end
		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in 'Email', with: user.email
				fill_in 'Password', with: user.password
				click_button('Log In')
			end

			it { should have_selector('p.alert.alert-success') }
			it { should have_title(user.name) }
		end
		describe "through visiting edit page" do
			before { visit profile_path } 
			it { should have_title 'Log In' }
		end
	end

	describe "friendly forwarding" do
		let(:user) { FactoryGirl.create(:user) }
		subject { page }
		describe "go to edit page while not logged in" do
			before do
				visit profile_path
				fill_in 'Email', with: user.email
				fill_in 'Password', with: user.password
				click_button 'Log In'
			end
			it { should have_title 'Edit Profile' }
		end


	end
end
