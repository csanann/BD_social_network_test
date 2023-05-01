# file: lib/post_repository.rb
require 'pg'
require_relative 'post'
require_relative 'database_connection'

class PostRepository
   
  def all
    connection = PG.connect(dbname: 'social_network_test')
    result = connection.exec('SELECT id, user_id, title, content, views FROM posts;')
 
    result.map do |row|
      post = Post.new
      post.id = row['id'].to_i
      post.user_id = row['user_id'].to_i
      post.title = row['title']
      post.content = row['content']
      post.views = row['views'].to_i
      post
    end
  end

  def find(id)
    connection = PG.connect(dbname: 'social_network_test')
    result = connection.exec('SELECT id, user_id, title, content, views FROM posts WHERE id = $1;', [id])
    
    return nil if result.ntuples.zero?

      row = result.first
      post = Post.new
      post.id = row['id'].to_i
      post.user_id = row['user_id'].to_i
      post.title = row['title']
      post.content = row['content']
      post.views = row['views'].to_i
      post
    end

  def create(post)
    #result = @db.exec_params('INSERT INTO posts (user_id, title, content, views) VALUES ($1, $2, $3, $4) RETURNING id;', [post.user_id, post.title, post.content, post.views])
    #post.id = result.first['id'].to_i if result.any?
    #post
    connection = PG.connect(dbname: 'social_network_test')
    result = connection.exec('INSERT INTO posts (user_id, title, content, views) VALUES ($1, $2, $3, $4) RETURNING id, user_id, title, content, views;', [post.user_id, post.title, post.content, post.views])
    
    row = result.first
      created_post = Post.new
      created_post.id = row['id'].to_i
      created_post.user_id = row['user_id'].to_i
      created_post.title = row['title']
      created_post.content = row['content']
      created_post.views = row['views'].to_i
      created_post
  end

  def delete(id)
    #@db.exec_params('DELETE FROM posts WHERE id = $1;', [id])
    DatabaseConnection.connect('social_network_test').exec_params('DELETE FROM posts WHERE id = $1;', [id])
  end

  def update(post)
    #@db.exec_params('UPDATE posts SET user_id = $1, title = $2, content = $3, views = $4 WHERE id = $5;', [post.user_id, post.title, post.content, post.views, post.id])
    connection = PG.connect(dbname: 'social_network_test')
    connection.exec_params('UPDATE posts SET user_id = $1, title = $2, content = $3, views = $4 WHERE id = $5;', 
      [post.user_id, post.title, post.content, post.views, post.id])
  
  end
end