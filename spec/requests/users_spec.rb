require 'rails_helper'

RSpec.describe "Users", :type => :request do
	subject { page }
	describe 'Signup Page' do
		before { visit signup_path }
		it { should have_title('Sign Up') }
		it { should have_content('Sign Up') }
		it { should have_selector('form') }
		fill_in('Name', with: 'Pedro')
		fill_in('Email', with: 'pedro@pedro.com')
		fill_in('Password', with: 'asdzxc')
		fill_in('Password Confirmation', with: 'asdzxc')
		click_button('Sign Up')
		# it { should  }
	end	
end
