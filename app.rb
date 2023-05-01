# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'

DatabaseConnection.connect('social_network')

# Initialize a user repository and retrieve a user by ID
user_repo = UserRepository.new
user = user_repo.find(2)


# Output the user's email and username
puts "Email: #{user.email}"
puts "Username: #{user.username}"

#---------------------------------------------
# Initialize a post repository and retrieve a post by ID
post_repo = PostRepository.new
post = post_repo.find(2)


# Output the post's title, content, and views
puts "Title: #{post.title}"
puts "Content: #{post.content}"
puts "Views: #{post.views}"
