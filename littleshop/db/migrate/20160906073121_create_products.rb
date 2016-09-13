class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal :price
      t.integer :amount_in_stock

      t.timestamps
    end
  end
end
