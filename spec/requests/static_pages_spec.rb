require 'rails_helper'

RSpec.describe "Static pages", :type => :request do
  subject { page }
  describe "Home page" do
    before { visit home_path }
    it { should have_content('Welcome') }
    it { should have_title('Home') }
  end

  subject { page }
  describe "Help page" do
    before { visit help_path }
    it { should have_selector('h1', text: 'Help page') }
    it { should have_title('Help') }
  end

  subject { page }
  describe "About page" do
    before { visit about_path }
    it { should have_selector('h1', text: 'About us') }
    it { should have_title('About') }
  end

  subject { page }
  describe "Contact page" do
    before { visit contact_path }
    it { should have_selector('h1', text: 'Contact') }
    it { should have_title('Contact') }
  end

  subject { page }
  describe "Other page" do
    before { visit other_path }
    it { should have_selector('h1', text: 'Other page') }
    it { should have_title('Another page') }
  end

end
