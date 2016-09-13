class Order < ApplicationRecord
  has_many :order_items
  before_save :update_subtotal

  validates :subtotal, numericality: { greater_than_or_equal_to: 0}

  def countSubtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

 private
  def update_subtotal
    self[:subtotal] = countSubtotal
  end
end
