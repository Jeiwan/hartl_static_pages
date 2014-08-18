require 'rails_helper'

RSpec.describe Micropost, :type => :model do
	before { @micropost = Micropost.new(post: "Hello, world!") }

	subject { @micropost }

	it { should respond_to(:user) }

	it { should be_valid }

	describe "when micropost is absent" do
		before { @micropost.post = nil }

		it { should_not be_valid }  
	end

	describe "when micropost is empty" do
		before { @micropost.post = ":)" }

		it { should_not be_valid }  
	end
	describe "when micropost is longe than 140 chars" do
		before { @micropost.post = "YO" * 140 }

		it { should_not be_valid }  
	end
end
