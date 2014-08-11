require 'rails_helper'

RSpec.describe "Sessions", :type => :request do
	subject { page }
	describe 'log in page' do
		before { visit login_path }
		it { should have_title('Log In') }
		it { should have_selector('form') }

		# fill_in 'Email', with: 'me@jeiwan.ru'
		# fill_in 'Password', with: 'asdzxc'
		# fill_in 'Password Confirmation', with: 'asdzxc'
	end
end
