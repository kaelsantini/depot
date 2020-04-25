class StoreController < ApplicationController
  include StoreCounter
  
  before_action :count_hits, olny: [:index]

  def index
    @products = Product.order(:title)
  end

end
