#file: lib/user_repository
require 'database_connection'
require_relative 'user'
require 'pg'

class UserRepository
 
  def all
    #execute the sql query
    #returns an arry of user objects

    #result = @db.exec("SELECT id, email, username FROM users;")
    #result.map { |row| User.new(row) }
    connection = PG.connect(dbname: 'social_network_test')
    result = connection.exec('SELECT id, email, username FROM users;')

    result.map do |row|
      user = User.new
      user.id = row['id'].to_i
      user.email = row['email']
      user.username = row['username']
      user
    end
  end


  def find(id)
    #execute the sql query:
    #returns a single user object

    connection = PG.connect(dbname: 'social_network_test')
    result = connection.exec('SELECT id, email, username FROM users WHERE id = $1;', [id])
    #check if number of returned rows directly using the 'ntuples' method
    #if there are no rows inthe result set return nil
    return nil if result.ntuples.zero?

    row = result.first
    user = User.new
    user.id = row['id'].to_i
    user.email = row['email']
    user.username = row['username']
    user
  end

  def create(user)
    #result = @db.exec_params('INSERT INTO users (email, username) VALUES ($1, $2) RETURNING id;', [user.email, user.username])
    #user.id = result.first['id'].to_i if result.any?
    #user
    #return nil if user.email.nil? || user.username.nil?
    return nil if user.email.nil? || user.username.nil?
    
    connection = PG.connect(dbname: 'social_network_test')
    result = connection.exec('INSERT INTO users (email, username) VALUES ($1, $2) RETURNING id, email, username;', [user.email, user.username])
    

    row = result.first
    user = User.new
    user.id = row['id'].to_i
    user.email = row['email']
    user.username = row['username']

    user    
  end

  def delete(id)
  #@db.exec_params("DELETE FROM users WHERE id = $1;", [id])
  
  sql = 'DELETE FROM users WHERE id = $1;'
  sql_params = [id]
  DatabaseConnection.exec_params(sql, sql_params)
  return nil
  post
  end

  def update(user)
    #@db.exec_params("UPDATE users SET email = $1, username = $2 WHERE id = $3;", [user.email, user.username, user.id])
    connection = PG.connect(dbname: 'social_network_test')
    connection.exec_params("UPDATE users SET email = $1, username = $2 WHERE id = $3;", [user.email, user.username, user.id])

  end
end