class CreateProductRates < ActiveRecord::Migration[5.1]
  def change
    create_table :product_rates, :id => false do |t|
      t.decimal :rate
      t.date :date

      t.timestamps
    end
    add_reference :product_rates, :product, foreign_key: true
  end
end
