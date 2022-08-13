# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom', photo: 'https://avatars.githubusercontent.com/u/92854204?v=4', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://avatars.githubusercontent.com/u/92854204?v=4', bio: 'Teacher from Poland.')