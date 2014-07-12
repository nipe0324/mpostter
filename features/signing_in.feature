Feature: サインインをする

Scenario: サインイン失敗
 Given a user visits the signin page
  When he submits invalid signin information
  Then he should see an error message

Scenario: サインイン成功
 Given a user visits the signin page
 	 And the user has an account
 	When the user submits valid signin information
 	Then he should see his profile page
 	  And he should see a signout link