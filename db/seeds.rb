# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


=begin

5.times do |index|
	Project.create!(name: Faker::Hipster.unique.word, 
					short_description: Faker::ChuckNorris.unique.fact, 
					long_description: Faker::Lorem.paragraph(30, false, 4),
					collect_amount_goal: [1000,1250,1500,1750,2000].sample,
					created_at: Faker::Time.between(5.days.ago, 2.days.ago, :all),
					updated_at: Faker::Time.between(2.days.ago, Date.today, :all),
					category_id: Faker::Number.between(1, 4)					
					)
end
=end
p "There is now #{Project.count} projects"

5.times do |index|
	Counterpart.create!(name: Faker::StarWars.unique.character, 
					amount: [20,30,50,75,100,250,500].sample,
					description: Faker::Simpsons.quote, 
					number: [20,30,50].sample,
					stock: Faker::Number.between(1, 20),
					created_at: Faker::Time.unique.between(5.days.ago, 2.days.ago, :all),
					updated_at: Faker::Time.unique.between(2.days.ago, Date.today, :all),
					stock_illimite: Faker::Boolean.boolean(0.3),
					project_id: Faker::Number.between(21, 17),				
					)
end



p "There is now #{Counterpart.count} counterparts"



