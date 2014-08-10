require 'rails_helper'

RSpec.describe "Static pages", :type => :request do
  describe "Home page" do
    it "should have the content 'Home page'" do
    	visit '/static_pages/home'
    	expect(page).to have_content('Home page')
    end

    it "should have the right title" do
    	visit '/static_pages/home'
    	expect(page).to have_title('Home')
    end
  end

  describe "Help page" do
  	it "should have the content 'Help page'" do
    	visit '/static_pages/help'
    	expect(page).to have_content('Help page')
  	end
    it "should have the right title" do
    	visit '/static_pages/help'
    	expect(page).to have_title('Help')
    end
  end

  describe "About page" do
  	it "should have the content 'About us'" do
    	visit '/static_pages/about'
    	expect(page).to have_content('About us')
  	end
    it "should have the right title" do
    	visit '/static_pages/about'
    	expect(page).to have_title('About')
    end
  end
end