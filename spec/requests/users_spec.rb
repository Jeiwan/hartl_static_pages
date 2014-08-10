require 'rails_helper'

RSpec.describe "Users", :type => :request do
	subject { page }
	describe 'Signup Page' do
		before { visit signup_path }
		it { should have_title('Sign Up') }
		it { should have_content('Sign Up') }
		# it { should }
	end	
end
