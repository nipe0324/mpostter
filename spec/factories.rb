FactoryGirl.define do
	factory :user do
		name			"Shoji Yanagi"
		email			"syanagi@example.com"
		password  "foobar"
		password_confirmation "foobar"
	end
end