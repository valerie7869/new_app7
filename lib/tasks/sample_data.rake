namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do 
		make_users
		make_microposts
		make_relationships
	end  # of task populate...
end 


	def make_users
		admin = User.create!(name: "Example User",
									email: "example@railstutorial.org",
									password: "foobar",
									password_confirmation: "foobar")
		admin.toggle!(:admin)  

		# Faker creates sample users for populating database
		33.times do |n|			# see listing 9.29
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end # of 33.times...creates 33 users
	end # of make_users
		
	def make_microposts
		# for 6 users..
		users = User.all(limit: 6)
		# create 35 microposts
		35.times do 
			content = Faker::Lorem.sentence(5)
			users.each { |user| user.microposts.create!(content: content) }
		end # of 35.times...
	end # of make_microposts

	def make_relationships
		users = User.all 
		user  = users.first
		followed_users = users[2..25]
		followers      = users[3..20]
		followed_users.each { |followed| user.follow!(followed) }
		followers.each      { |follower| follower.follow!(user) }
	end

