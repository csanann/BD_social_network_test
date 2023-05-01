#file: lib/user.rb

class User
    
    attr_accessor :id, :email, :username

    def initialize(id = nil, email = nil, username = nil)
        @id = id
        @email = email
        @username = username
    end
end