class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  def show
    @count_product=Product.count
    @count_category=Category.count
  end
end
