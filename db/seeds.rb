# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 1. On nettoie la base de données pour repartir de zéro à chaque run
require 'faker'

puts "Cleaning database..."
Movie.destroy_all
User.destroy_all

puts "Creating one master user..."
user = User.create!(
  email: "admin@watchlist.com",
  password: "password"
)

puts "Creating 50 movies..."

50.times do |i|
  movie = Movie.create!(
    title: Faker::Movie.unique.title,
    description: Faker::Lorem.paragraph(sentence_count: 3), # Respecte ta validation > 10 car.
    overview: Faker::Movie.quote,
    genre: ["Action", "Comedy", "Drama", "Horror", "Sci-Fi", "Animation"].sample,
    rating: rand(1.0..10.0).round(1),
    # Utilisation de Picsum ou Unsplash pour avoir 50 images différentes
    poster_url: "https://picsum.photos/seed/#{i + 40}/400/600",
    user: user
  )
  puts "Movie #{i + 1}: #{movie.title} created!"
end

puts "Finished! Created #{Movie.count} movies."
