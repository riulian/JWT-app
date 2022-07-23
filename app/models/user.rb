class User < ApplicationRecord
    validates :email, :uniqueness => { :case_sensitive => false }
    
    has_secure_password
    validates :password, presence: true, length: { minimum: 1 }
end
