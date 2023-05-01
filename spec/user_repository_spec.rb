# file: user_repositoty_spec.rb
require 'pg'
require 'user'
require 'user_repository'
require 'database_connection'


def reset_database_tables
  seed_sql = File.read('spec/seeds_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test'})
  connection.exec("TRUNCATE users, posts CASCADE;")
  connection.exec(seed_sql)
  #connection.exec_params("UPDATE users SET email = $1 WHERE username = $2", ["test1@example.com", "test1"])
end

RSpec.describe UserRepository do
  before(:each) do
    reset_database_tables
  end

#  let(:db) {PG.connect(host: '127.0.0.1', dbname: 'social_network_test')}
#using repo viarable, the value is catched across multiple calls in the same example 
let(:repo) { UserRepository.new }
  
  describe "#all" do    
    it "returns all users" do
      repo = UserRepository.new
      users = repo.all

      expect(users.length).to eq(2)
      expect(users.first.email).to eq('test1@example.com')
      expect(users.first.username).to eq('test1')

      expect(users.last.email).to eq('test2@example.com')
      expect(users.last.username).to eq('test2')
    end
  end

  describe "#find" do
    it "returns the user with the given id" do
      user = repo.find(1)
      expect(user.id).to eq(1)
      expect(user.email).to eq('test1@example.com')
      expect(user.username).to eq('test1')
    end

    it "returns nil if the user is not found" do
      user = repo.find(999)
      expect(user).to be_nil
    end
  end

  describe "#create" do
    it "creates a new user" do
      user = User.new
      user.email = 'test@example.com'
      user.username = 'test3'

      created_user = repo.create(user)

      expect(created_user.id).to eq(3)
      expect(created_user.email).to eq('test@example.com')
      expect(created_user.username).to eq('test3')

      users = repo.all
      expect(users.count).to eq(3)
    end
  end

  describe "#delete" do
    let(:repo) { UserRepository.new}

    it "deletes the user with by id" do
      user = User.new
      user.email = 'test@example.com'
      user.username = 'testuser'

      created_user = repo.create(user)
      expect(created_user).not_to be_nil

      repo.delete(created_user.id)

      found_user = repo.find(created_user.id)
      expect(found_user).to be_nil
    end
  end

  describe "#update" do
    it "updates the user with the given id" do
     
      user = repo.find(1)
      user.username = 'new_username'
      repo.update(user)

      updated_user = repo.find(1)
      expect(updated_user.email).to eq('test1@example.com')
      expect(updated_user.username).to eq('new_username')
    end
  end
end