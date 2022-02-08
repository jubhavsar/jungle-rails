require 'rails_helper'

 RSpec.describe User, type: :model do

   describe 'Validations' do
     # validation examples here
     context "password" do
       it "should not be blank" do
         @user = User.create(
           name: "harry",
           email: "123@123.ca"
         )
          expect(@user.errors.full_messages).to include("Password can't be blank")
       end
     end

     context "password confirmation" do
       it "should not be blank" do

       @user = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wizzard"
       )
       expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
       end
     end

     context "password and password confirmation" do
       it "should match" do
         @user = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wizzard",
         password_confirmation: "wiz"
       )
       expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
       end
     end

     context "email" do
       it "should be unique in the database" do
       # //check if database alreadye exists, fail if to_lowercase exists in db 
       @user = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wizard",
         password_confirmation: "wizard"
         )
       @user2 = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wizard",
         password_confirmation: "wizard"
         )
       expect(@user2.errors.full_messages).to include("Email has already been taken")
       end
     end

     context "email" do
       it "should exist" do
         @user = User.create(
         name: "harry",
         password: "wizard",
         password_confirmation: "wizard"
         )
         expect(@user.errors.full_messages).to include("Email can't be blank")
       end
     end

     context "name" do
       it "should exist" do
         @user = User.create(
           password: "wizard",
           email: "123@123.ca",
           password_confirmation: "wizard"
           )
           expect(@user.errors.full_messages).to include("Name can't be blank")
       end
     end

     context "password" do
       it "should be greater than 6 characters" do
         @user = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wiz",
         password_confirmation: "wiz"
         )
       expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
       end
     end
   end

   describe '.authenticate_with_credentials' do
     it "should return a user if email and password match" do
       user = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wizard",
         password_confirmation: "wizard"
         )
         response = user.authenticate_with_credentials(user.email, user.password_digest)
       expect(response).not_to be_nil
       expect(response[:email]).to eq(user.email)
     end

     it "should return null if email and password dont match" do
       user = User.create(
         name: "harry",
         email: "123@123.ca",
         password: "wizard",
         password_confirmation: "wizard"
         )
         response = user.authenticate_with_credentials(user.email, "wozard")
       expect(response).to be_nil
     end
   end
 end