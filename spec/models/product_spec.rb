require 'rails_helper'

 RSpec.describe Product, type: :model do
   describe 'Validations' do
    
     it 'should save a valid product' do
       @category = Category.create(name:"Food")
       product = Product.new(
         name: "Pineapple",
         price_cents: 34.00,
         quantity: 15,
         category_id: @category.id
         )
       expect(product).to (be_valid)
     end

     it 'should not save without valid name' do
       @category = Category.create(name: "Food")
       name = Product.new(
         name: nil,
         price_cents: 34.00,
         quantity: 15,
         category_id: @category.id
         )
       name.save
       expect(name.errors.full_messages.first).to eq("Name can't be blank")
       expect(name).to_not (be_valid)
     end

     it 'should not save without valid price' do
       @category = Category.create(name: "Food")
       price = Product.new(
         name: "Cat Socks",
         price_cents: nil,
         quantity: 15,
         category_id: @category.id
         )
        price.save
        expect(price.errors.full_messages.first).to eq("Price cents is not a number")
        expect(price).to_not (be_valid)
     end

     it 'should not save without valid quantity' do
       @category = Category.create(name: "Food")
       quantity = Product.new(
         name: "Hot Dog",
         price_cents: 34.00,
         quantity: nil,
         category_id: @category.id
         )
         quantity.save
         expect(quantity.errors.full_messages.first).to eq("Quantity can't be blank")
         expect(quantity).to_not (be_valid)
     end

     it 'should not save without valid category id' do
       @category = Category.create(name: "Food")
       category_id = Product.new(
         name: "Chocos",
         price_cents: 34.00,
         quantity: 15,
         category_id: nil
         )
         category_id.save
         expect(category_id.errors.full_messages.first).to eq("Category can't be blank")
         expect(category_id).to_not (be_valid)
     end
   end
 end