class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales, :id => false do |t|
      t.decimal :price
      t.integer :quantity
      t.date :date

      t.timestamps
    end
    add_reference :sales, :product, foreign_key: true
  end
end
