class StoreController < ApplicationController
  include CurrentCart, StoreCounter

  skip_before_action :authorize
  before_action :set_cart
  before_action :count_hits, olny: [:index]

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end

end
