require 'rails_helper'

RSpec.describe User, :type => :model do
	before { @user = User.new(name: "Example User", email: "user@example.com", password: '123456', password_confirmation: '123456') }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }

	it { should be_valid }

	describe "when name is not provided" do
		before { @user.name = "" }
		it { should_not be_valid }
	end
	describe "when name is too long" do
		before { @user.name = "a" * 33 }
		it { should_not be_valid }
	end
	describe "when name is too short" do
		before { @user.name = "aa" }
		it { should_not be_valid }
	end
	describe "when email is not provided" do
		before { @user.email = "" }
		it { should_not be_valid }
	end
	describe "when email is not unique" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end
	describe "when password is not provided" do
		before { @user = User.new(name: "Example User", email: "user@example.com", password: ' ', password_confirmation: ' ') }
		it { should_not be_valid }
	end
	describe "when password length is wrong" do
		before { @user.password = "12345" }
		it { should_not be_valid }
	end
	describe "when password confirmation is not provided" do
		before { @user.password_confirmation = "" }
		it { should_not be_valid }
	end
	describe "when password and password confirmation do not match" do
		before do
			@user.password = "123456"
			@user.password_confirmation = "654321"
		end
		it { should_not be_valid }
	end
	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }
		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end
end
