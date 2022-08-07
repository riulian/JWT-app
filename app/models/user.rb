class User < ApplicationRecord
    validates :email, :uniqueness => { :case_sensitive => false }
    has_many  :books
    has_secure_password
    validates :password, presence: true, length: { minimum: 1 }
    
    def to_jsonn
        #@k=JSON.pretty_generate(Book.where(user_id: self.id).to_json) 
        @k=Book.where(user_id: self.id).to_json

        {a: 'a',email: self.email,carti: [@k], date: {date1: "salut"}}
      end  
end
