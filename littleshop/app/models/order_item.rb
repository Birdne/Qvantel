class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  #checks that quantity is present and it is an integer that is greater than zero
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: :amount_in_stock }
  #checking that product and order are present and valid
  validates :product, presence: true
  validates :order, presence: true

  before_save :finalize

  # returns the products price. It first  checks if the price saved to the unit_price field is the same as the products price. If the pruduct has changed price after it was added to the cart it can still be bought at the previous price that was saved to the unit_price field when it was fisrt added to the order.
  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

 private
  def amount_in_stock
    product.amount_in_stock
  end

  # Updates the unit_price and total_price fields with proper values before saving
  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
