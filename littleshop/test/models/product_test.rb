require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product has to have a name" do
    product = Product.new
    product.amount_in_stock = 10
    product.price = 10.00
    assert_not product.save, "Saved a product without name"
  end

  test "product has to have a proper price" do
    product = Product.new
    product.amount_in_stock = 10
    product.product_name = "Kissa"
    assert_not product.save, "Saved a product without price"
    product.price = "kissa"
    assert_not product.save, "Saved a product when price was string"
    product.price = -10
    assert_not product.save, "Saved a product when price was negative"
    product.price = "10"
    assert product.save, "Didn't save a product when price was int"
    product.price = "10.001"
    assert_not product.save, "Saved a product when price was three decimals"
    product.price = "10.01"
    assert product.save, "Didn't save a product when price was two decimal long number"
  end

  test "product has to have a proper amount in stock" do
    product = Product.new
    product.price = 10
    product.product_name = "Kissa"
    assert_not product.save, "Saved a product without amount in stock"
    product.amount_in_stock = "kissa"
    assert_not product.save, "Saved a product when amount in stock was string"
    product.amount_in_stock = -10
    assert_not product.save, "Saved a product when amount in stock was negative"
    product.amount_in_stock = "10.001"
    assert_not product.save, "Saved a product when amount in stock was decimal"
    product.amount_in_stock = "10"
    assert product.save, "Didn't save a product when amount in stock was int"
  end
end

