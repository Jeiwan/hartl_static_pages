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

			# click_button('Log In')
			# expect(response).to redirect_to(user_path(user))
		end
	end
end
