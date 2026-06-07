# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data (optional)
PostEditing.destroy_all
Post.destroy_all
User.destroy_all

# Create Users
user1 = User.create!(
  name: "Amir Mawla",
  email: "amir@example.com",
  DOP: Date.new(1990, 5, 15),
  phone_number: "1234567890"
)

user2 = User.create!(
  name: "Islam Sulman",
  email: "islam@example.com",
  DOP: Date.new(1992, 8, 20),
  phone_number: "0987654321"
)

user3 = User.create!(
  name: "Omar abdelrahman",
  email: "omar@example.com",
  DOP: Date.new(1988, 12, 10),
  phone_number: "5556667777"
)

# Create Posts
post1 = Post.create!(
  title: "Ruby on Rails Basics",
  content: "This post explains the basics of Ruby on Rails.",
  creator: user1
)

post2 = Post.create!(
  title: "Active Record Associations",
  content: "This post covers belongs_to, has_many, and has_one.",
  creator: user2
)

post3 = Post.create!(
  title: "Rails Validations",
  content: "This post discusses model validations in Rails.",
  creator: user1
)

# Create Post Editings
PostEditing.create!(
  post: post1,
  editor: user2
)

PostEditing.create!(
  post: post1,
  editor: user3
)

PostEditing.create!(
  post: post2,
  editor: user1
)

PostEditing.create!(
  post: post3,
  editor: user2
)

puts "Created #{User.count} users"
puts "Created #{Post.count} posts"
puts "Created #{PostEditing.count} post editings"