#file: lib/post.rb

class Post
    attr_accessor :id, :user_id, :title, :content, :views

    def initialize(id = nil, user_id = nil, title = nil, content = nil, views = nil)
        @id = id
        @user_id = user_id
        @title = title
        @content = content
        @views = views
    end
end