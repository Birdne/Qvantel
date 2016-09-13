require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "product present in order item" do
    order = Order.new
    order_item = order.order_items.new()
    assert_not order_item.save, "Saved an order item without a refenrence to a product"
  end

  # Not sure if this would work like this
  test "no product reference in order item" do
    order = Order.new
    order_item = order.order_items.new()
    order_item.quantity = 5
    assert_not order_item.save, "Saved an order item without a refenrence to a product"
  end
end
