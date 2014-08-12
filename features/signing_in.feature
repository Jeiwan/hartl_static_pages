Feature: Signing in
	Scenario: Unsuccessful signin
		Given a user visits the signin page
		When they submit invalid signin information
		Then they should see an error message
	Scenario: Successful signin
		Given a user visits the signin page
			And the user has an account
		When the user submits valid signin information
		Then the user should see his/her profile page
			And the user should see a signout link