class Product < ApplicationRecord
  has_many :order_items

 validates :product_name, presence: true, length: { minimum: 2 } 
 validates :price, presence: true, numericality: { greater_than: 0.00 }
 validates :amount_in_stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

# , format: { with: /^\d+(\.\d{2})?$/}
