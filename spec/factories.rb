FactoryGirl.define do
	factory :user do 
		name 		"Valerie Sample"
		email 	"vsample@example.com" 
		password "foobar" 
		password_confirmation "foobar" 
	end
end