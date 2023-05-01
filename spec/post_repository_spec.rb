# file: spec/post_repository_spec.rb
require 'pg'
require 'post'
require 'post_repository'
require 'user_repository_spec'
require 'database_connection'


def reset_database_tables
  seed_sql = File.read('spec/seeds_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test'})
  connection.exec(seed_sql)
  #connection.exec_params("UPDATE users SET email = $1 WHERE username = $2", ["test1@example.com", "test1"])
end

RSpec.describe PostRepository do
  before(:each) do
    reset_database_tables 
  end

#  let(:db) { PG.connect({ host: '127.0.0.1', dbname: 'social_network_test'}) }
  let(:repo) { PostRepository.new }   

  describe "#all" do
    it "returns all posts" do
      repo = PostRepository.new
      posts = repo.all

      expect(posts.length).to eq(2)

      expect(posts.first.id).to eq(1)
      expect(posts.first.user_id).to eq(1)
      expect(posts.first.title).to eq('My First Post')
      expect(posts.first.content).to eq('Hello, world!')
      expect(posts.first.views).to eq(10)
    end
  end

  describe "#find" do
    it "returns the post with the given id" do
      post = repo.find(1)

      expect(post.id).to eq(1)
      expect(post.user_id).to eq(1)
      expect(post.title).to eq('My First Post')
      expect(post.content).to eq('Hello, world!')
      expect(post.views).to eq(10)
    end

    it "returns nil if the post is not found" do
      post = repo.find(999)

      expect(post).to be_nil
    end
  end

  describe "#create" do
    it "creates a new post" do
      user_repo = UserRepository.new
      user = user_repo.find(1)

      post = Post.new
      post.user_id = user.id
      post.title = 'new user Title'
      post.content = 'new User content'
      post.views = 0

      created_post = repo.create(post)

      expect(created_post.id).not_to be_nil
      expect(created_post.user_id).to eq(1)
      expect(created_post.title).to eq('new user Title')
      expect(created_post.content).to eq('new User content')
      expect(created_post.views).to eq(0)

      posts = repo.all
      expect(posts.count).to eq(3)
    end
  end

  describe "#delete" do
    let(:repo) { PostRepository.new}

    it "deletes the post by id" do
      post = Post.new
      post.user_id = 1
      post.title = 'Test Title'
      post.content = 'Test content'
      post.views = 0
      
      created_post = repo.create(post)
      expect(created_post).not_to be_nil

      repo.delete(created_post.id)

      found_post = repo.find(created_post.id)
      expect(found_post).to be_nil
    end 
  end


  describe "#update" do
    it "updates the post with the given id" do
     
      post = repo.find(1)
      post.views = 3
      repo.update(post)

      updated_post = repo.find(1)
      expect(updated_post.title).to eq('My First Post')
      expect(updated_post.content).to eq('Hello, world!')
      expect(updated_post.user_id).to eq(1)
      expect(updated_post.views).to eq(3)
    end
  end
end