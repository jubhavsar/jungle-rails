include BCrypt

 class User < ActiveRecord::Base

   has_secure_password

   validates :password, presence: true
   validates :password_confirmation, presence: true
   validates :password, confirmation: true
   validates :password, length: { minimum: 6 }  
   validates :email, uniqueness: true
   validates :email, presence: true
   validates :name, presence: true


   def authenticate_with_credentials(userEmail, userPassword)
     # check if exists in the db return user object or nil

     user = User.find_by(email: userEmail)

     if (Password.new(user[:password_digest]).to_s == userPassword)
       return user
     else
       return nil
     end
   end

 end