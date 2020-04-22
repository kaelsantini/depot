require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  def new_product(image_url)
    Product.new(title: "The test book", description: "ZZZ", price: 1, image_url: image_url)
  end

  test "product attributes must be not empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "The test book", description: "ZZZ", image_url: "test.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://static/img/a.jpg https://static.com/img/a.gif }
    bad = %w{ fred.doc fred.giff fred.gif.more fred.gif/more http://static/images/a.com }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} shouldn't be valid"
    end    
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "ZZZ",
                          price: 1,
                          image_url: "image.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test "product title must have at least ten chars" do
    product = Product.new(title: "Too short",
                          description: "ZZZ",
                          price: 1,
                          image_url: "image.gif")
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]

    product.title = "More than ten chars"
    assert product.valid?
  end

end
