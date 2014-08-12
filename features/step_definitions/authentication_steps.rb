Given /^a user visits the signin page$/ do
	visit login_path
end

When(/^they submit invalid signin information$/) do
	click_button 'Log In'
end

Then(/^they should see an error message$/) do
	expect(page).to have_selector('p.alert.alert-danger')
end

Given(/^the user has an account$/) do
	@user = User.create(name: 'Sancho Panza', email: 'sancho@panza.es', password: 'dfgcvb', password_confirmation: 'dfgcvb')
end

When(/^the user submits valid signin information$/) do
	fill_in 'Email', with: @user.email
	fill_in 'Password', with: @user.password
	click_button 'Log In'
end

Then(/^the user should see his\/her profile page$/) do
	expect(page).to have_content(@user.name)
end

Then(/^the user should see a signout link$/) do
	expect(page).to have_selector('a', text: 'Log out')
end