FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Sancho Panza #{n}" }
		sequence(:email) { |n| "sancho#{n}@panza.es" }
		password "dfgcvb"
		password_confirmation "dfgcvb"
		
		factory :admin do
			admin true
		end
	end
end