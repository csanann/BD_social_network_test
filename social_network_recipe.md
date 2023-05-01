Two Tables Design Recipe Template
# : social_network
Project structure:

social_network/
  ├── lib/
  │   ├── user.rb
  │   ├── post.rb
  │   ├── user_repository.rb
  │   └── post_repository.rb
  ├── spec/
  │   ├── user_spec.rb
  │   ├── post_spec.rb
  │   ├── user_repository_spec.rb
  |   |-- seeds_test.sql
  │   └── post_repository_spec.rb
  ├── db/
  │    ├── data.sql  #insert data
  │    ├── truncate.sql  
  │    ├── create_tables.sql   #schema.sql # the sql queries to create the tables for user and post
  └── social_network_recipe.md
  └──Gemfile


1. Extract nouns from the user stories or specification

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

# Nouns: user, email, username, post, title, content, views

2. Infer the Table Name and Columns

Record: user, post	
Properties: user: email, username
            post: title, content, views

Name of the first table (always plural): users

Column names: email, username

Name of the second table (always plural): posts

Column names:title, content, views

3. Decide the column types.

users:
id, email, username

posts:
id, title, content, views, user_id


4. Decide on The Tables Relationship

Can one user have many POSTS? (Yes)
Can one post  have many users? (No)

-> Therefore,
-> An user HAS MANY posts
-> An post BELONGS TO a user

-> Therefore, the foreign key is on the posts table.


4. Write the SQL.

-- # file: bd/create_tables.sql

-- create the users table
CREATE TABLE users (
   id SERIAL PRIMARY KEY,
   email VARCHAR(100) UNIQUE NOT NULL,
   username VARCHAR(100) UNIQUE NOT NULL
);

-- create the posts table
CREATE TABLE posts (
   id SERIAL PRIMARY KEY,
   user_id INTEGER NOT NULL,
   title VARCHAR(200) NOT NULL,
   content TEXT NOT NULL,
   views INTEGER DEFAULT 0,
   FOREIGN KEY (user_id) REFERENCES users(id)
);

-- # file: db/truncate.sql
-- truncate the posts table and reset the id sequence

TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO users (id, email, username) VALUES (1, 'test1@example.com', 'user1');
INSERT INTO users (id, email, username) VALUES (2, 'test2@example.com', 'user2');


-- # file: db/data.sql
-- insert some sample data

INSERT INTO users (email, username) VALUES ('user1@example.com', 'user1');
INSERT INTO users (email, username) VALUES ('user2@example.com', 'user2');
INSERT INTO users (email, username) VALUES ('user3@example.com', 'user3');

INSERT INTO posts (user_id, title, content, views) VALUES (1, 'Title1', 'User content1', 1);
INSERT INTO posts (user_id, title, content, views) VALUES (2, 'Title2', 'User content2', 2);
INSERT INTO posts (user_id, title, content, views) VALUES (3, 'Title3', 'User content3', 0);

=Run the scripts in psql: to create the tables with the required fields.
psql -h 127.0.0.1 -d social_network_test -f db/create_tables.sql
psql -h 127.0.0.1 -d social_network_test -f db/data.sql
psql -h 127.0.0.1 -d social_network_test -f db/truncate.sql

----For Testing Purpose-----
-- to create two tables 
--file spec/seeds_test.sql

-- Truncate the tables to clear out previous test data
TRUNCATE TABLE users CASCADE;
TRUNCATE TABLE posts CASCADE;

-- Insert some sample user records
INSERT INTO users (email, username) VALUES ('test1@example.com', 'test1');
INSERT INTO users (email, username) VALUES ('test1@example.com', 'test2');

-- Insert some sample post records
INSERT INTO posts (user_id, title, content, views) VALUES (1, 'My First Post', 'Hello, world!', 10);
INSERT INTO posts (user_id, title, content, views) VALUES (2, 'Another Post', 'This is another post.', 5);

-- psql -h 127.0.0.1 -d social_network_test -f spec/seeds_test.sql

# psql -h 127.0.0.1 social_network_test < ./spec/seeds_test.sql

6. Define the class names

A. 
# Table name: users

# Model class
# (in lib/user.rb)
class Users
 
end

# Repository class
# (in lib/users_repository.rb)
class UsersRepository
  
  def all
    # Executes the SQL query
    #result_set to connection
    #create users list    
    #code block to get all users by id, email, username
    # adds user into the list of users 
    # Returns an array of User objects.
  end


  def find(id)
    #object+sql code
  end

  def create(user)
    #object+sql code
  end

  def delete(id)
    #object+sql code
  end

  def update
    #object+sql code
  end
end

B.
# Table name: posts

# Model class
# (in lib/post.rb)
class Posts
  
end


# Repository class
# (in lib/posts_repository.rb)
class PostRepository
  def initialize(connection)
    #object+sql code connection to host
  end

  def all
    #object+sql code
  end

  def find(id)
    #object+sql code
    # condition if can't find that id
  end

  def create(post)
    #object+sql code
  end

  def delete(id)
    #object+sql code
  end

  def clear_all
    #object+sql code
  end
end

7. Implement the Model class

# Table name: users
# Model class
# (in lib/user.rb)
class Users
 attr_accessor :id, :email, :username
  def initialize(id, email, username)
  #
  end
end
========
# Table name: posts
# Model class
# (in lib/post.rb)

class Posts
  attr_accessor :id, :user_id, :title, :content, :views

  def initialize(id, user_id, title, content, views)
  #
  end
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.


8. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.


Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


# EXAMPLE
# Table name: users


# Repository class
# (in lib/users_repo)


class UsersRepository


 # Selecting all records
 # No arguments
 def all
   # Executes the SQL query:
   # SELECT id, email, username FROM users;


   # Returns an array of User objects.
 end
end


9. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.


RSpec tests. > create user_repository_spec.rb to test


# 1
# Get all users
returns all users
repo = UsersRepository.new
users = repo.all

users.length #=> 2
users.first.email #=> 'alice@example.com'
users.first.username #=> 'alice'

# 2
# find users
returns the user with the given id
repo = UsersRepository.new
user = repo.find(1)

user.first.email #=> 'alice@example.com'
user.first.username #=> 'alice'

returns nill if hte user is not found
user = repo.fine(999)

user > .to be_nil

# 3 create users
creates a new user
user = User.new(email:, username: )
new_user = repo.create(user)


new_user.id #=> .not_to be_nil
new_user.email #=> 'bob@example.com'
new_user.username #=> 'bob'

# 4
# delete users
deletes the user with the given id
repo.delete(1)
users = repo.all

users.length  => 1
user.first.email #=> 'bob@example.com'
user.first.username #=> 'bob'

# 5
# update users
updates the user with the given id
user = repo.find(1)
user.username = 'new_username'
updated_user = repo.update(user)

updated_user.email => 'alice@example.com'
updated_user.username => 'new_username'
============
PostRepository

1. #all
returns all posts
posts = repo.all

posts.length => 2
posts.first.title => 'title1'
posts.first.content => 'User content'
posts.first.user_id => 2222
posts.first.views =>1

2. #find
returns the post with the given id
post = repo.find(1)

posts.title => 'title1'
posts.content => 'User content'
posts.user_id => 2222
posts.views =>1

returns nil if the post if not found
post = repo.find(999)

post => .to be_nil

3. #create
creates a new post
post = Post.new(user_id: 3333, title: 'Title3', content: 'User content3', views: 0)
new_post = repo.create(post)

new_post.id =>.not_to be_nil
new_post.user_id => 3333
new_post.title => 'Title3'
new_post.content => 'User content3'
new_post.views => 0

4. #delete
deletes the post with the given id
repo.delete(1)
posts = repo.all

posts.length =>1
posts.first.title => 'title2'
posts.first.content => 'User content2'
posts.first.user_id => 3333
posts.first.views =>2

5 #update
updates the post with the given id
post = repo.find(1)
post.views = 3
updated_post = repo.updated(post)

updated_post.title => 'Title1'
updated_post.content => 'User content1'
updated_post.user_id => 2222
updated_post.views =>3

10. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

# file: spec/users_repository_spec.rb

def reset_users_table
 seed_sql = File.read('spec/seeds_test.sql')
 connection = PG.connect({ host: '127.0.0.1', dbname: 'users' })
 connection.exec(seed_sql)
end


describe UsersRepository do
 before(:each) do
   reset_users_table
 end
# file: spec/posts_repository_spec.rb

def reset_posts_table
 seed_sql = File.read('spec/seeds_test.sql')
 connection = PG.connect({ host: '127.0.0.1', dbname: 'posts' })
 connection.exec(seed_sql)
end


describe PostsRepository do
 before(:each) do
   reset_posts_table
 end

 # (your tests will go here).
end
11. Test-drive and implement the Repository class behavior



