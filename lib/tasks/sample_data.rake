namespace :db do
	desc 'Fill database with sample data'

	task populate: :environment do
		User.create!(name: 'Ivan', email: 'me@jeiwan.ru', password: 'dfgcvb', password_confirmation: 'dfgcvb', admin: true)
		99.times do |x|
			name = Faker::Name.name
			email = "#{name}-#{x}@imafak.er"
			password = "dfgcvb"
			user = User.create!(name: name, email: email, password: password, password_confirmation: password, admin: false)	
			rand(30..100).times do |x|
				user.microposts << Micropost.create(post: Faker::Lorem.sentence[0..rand(140)])
			end
		end
	end
end