class User < ApplicationRecord
    
    validates :password, length: (8..20), allow_nil: true
    attr_reader :password

        # note: this is a class method
    def self.find_from_credentials(username, password)
        user = find_by(username: username) # same as User.find_by( ... )
        return nil unless user
        user if user.is_password?(password)
    end


    def is_password?(password_attempt)
        BCrypt::Password.new(password_digest).is_password?(password_attempt)
    end

    def password=(raw_password)
        @password = password
        self.password_digest = BCrypt::Password.create(raw_password)
    end


end
