class StoreController < ApplicationController
  include CurrentCart, StoreCounter

  before_action :set_cart
  before_action :count_hits, olny: [:index]

  def index
    @products = Product.order(:title)
  end

end
