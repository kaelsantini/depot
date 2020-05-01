require 'test_helper'

class CartTest < ActiveSupport::TestCase
  
  fixtures :products, :carts

  test "should have unique products in cart" do
    cart = carts(:my_cart)

    # Line Items fixture setups two products in :my_cart
    assert_equal 2, cart.line_items.length
    assert_equal 1, cart.line_items.find_by(product_id: products(:ruby).id).quantity
    assert_equal 2, cart.line_items.find_by(product_id: products(:two).id).quantity

    # Try adding product already added
    line_item = cart.add_product(products(:ruby))
    line_item.save
    assert_equal 2, cart.line_items.length
    assert_equal 2, cart.line_items.find_by(product_id: products(:ruby).id).quantity 

    # Try adding new product
    line_item = cart.add_product(products(:one))
    line_item.save
    assert_equal 3, cart.line_items.length
    
    # Check quantity
    assert_equal 1, cart.line_items.find_by(product_id: products(:one).id).quantity
    # Add one more
    line_item = cart.add_product(products(:one))
    line_item.save
    # Check quantity
    assert_equal 2, cart.line_items.find_by(product_id: products(:one).id).quantity

  end

  test "duplicated products in cart should be invalid" do
    cart = carts(:his_cart)
    


  end

end
