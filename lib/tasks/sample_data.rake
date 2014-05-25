namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do 
		admin = User.create!(name: "Example User",
									email: "example@railstutorial.org",
									password: "foobar",
									password_confirmation: "foobar")
		admin.toggle!(:admin)  

		# Faker creates sample users for populating database
		99.times do |n|			# see listing 9.29
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end # of 99.times...
		
		users = User.all(limit: 10)
		50.times do 
			content = Faker::Lorem.sentence(5)
			users.each { |user| user.microposts.create!(content: content) }
		end # of 50.times...


	end  # of task populate...
end